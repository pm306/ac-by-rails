class OutfitSelectionRulesController < ApplicationController
  before_action :require_login, only: %i[index new create show select_outfit destroy select_outfit]
  before_action :set_cloth_groups, only: [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :rule_not_found

  def index
    @outfit_selection_rules = OutfitSelectionRule.all
  end

  def show
    @outfit_selection_rule = OutfitSelectionRule.includes(:cloth_groups).find(params[:id])
  end

  def new
    @outfit_selection_rule = OutfitSelectionRule.new
  end

  def create
    @outfit_selection_rule = OutfitSelectionRule.new(outfit_selection_rule_params.except(:cloth_group_selections))

    ActiveRecord::Base.transaction do
      @outfit_selection_rule.save!
      process_cloth_group_selections(@outfit_selection_rule,
                                     params[:outfit_selection_rule][:cloth_group_selections] || {})
    end

    redirect_with_notice(I18n.t('flash.outfit_selection_rules.create_success'), rules_url)
  rescue ActiveRecord::RecordInvalid
    render_with_alert(I18n.t('flash.outfit_selection_rules.create_failure'), :new)
  end

  def destroy
    @outfit_selection_rule = OutfitSelectionRule.includes(:cloth_groups).find(params[:id])
    if @outfit_selection_rule.destroyable?
      @outfit_selection_rule.destroy
      redirect_with_notice(I18n.t('flash.outfit_selection_rules.destroy_success'), rules_url)
    else
      redirect_with_alert(I18n.t('flash.outfit_selection_rules.destroy_failure'), rules_url)
    end
  end

  def select_outfit
    max_temperature = params[:max_temperature]
    min_temperature = params[:min_temperature]
    flash[:max_temperature] = max_temperature
    flash[:min_temperature] = min_temperature

    unless valid_number?(max_temperature) && valid_number?(min_temperature)
      redirect_with_alert(I18n.t('flash.outfit_selection_rules.invalid_number'), root_url)
      return
    end

    if min_temperature > max_temperature
      redirect_with_alert(I18n.t('flash.outfit_selection_rules.min_over_max'), root_url)
      return
    end

    outfit_selector = OutfitSelector.new(current_user)
    selected_clothes_ids = outfit_selector.select_outfit(max_temperature, min_temperature)
    if selected_clothes_ids
      session[:selected_clothes_ids] = selected_clothes_ids
      session[:outfit_selected] = true
      redirect_to root_url
    else
      redirect_with_alert(I18n.t('flash.outfit_selection_rules.select_failure'), root_url)
    end      
  end

  private
  def outfit_selection_rule_params
    params.require(:outfit_selection_rule).permit(:name, :description, :priority,
                                                  :min_temperature_lower_bound, :min_temperature_upper_bound,
                                                  :max_temperature_lower_bound, :max_temperature_upper_bound,
                                                  cloth_group_selections: {})
  end

  def process_cloth_group_selections(rule, selections_params)
    selections_params.each do |cloth_group_id, selection_count|
      next unless selection_count.to_i.positive?

      ClothGroupSelection.create!(
        outfit_selection_rule_id: rule.id,
        cloth_group_id:,
        selection_count:
      )
    end
  end

  def set_cloth_groups
    @cloth_groups = ClothGroup.all
  end

  def valid_number?(str)
    true if Float(str)
  rescue StandardError
    false
  end

  def rule_not_found
    redirect_with_alert(I18n.t('flash.outfit_selection_rules.not_found'), root_url)
  end
end
