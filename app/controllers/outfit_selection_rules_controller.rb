class OutfitSelectionRulesController < ApplicationController
  before_action :require_login, only: [:index, :new, :create, :show, :select_outfit, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :rule_not_found

  def index
    @outfit_selection_rules = OutfitSelectionRule.all
  end

  def new
    @outfit_selection_rule = OutfitSelectionRule.new
    @cloth_groups = ClothGroup.all
  end

  def create
    @outfit_selection_rule = OutfitSelectionRule.new(outfit_selection_rule_params.except(:cloth_group_selections))

    ActiveRecord::Base.transaction do
      @outfit_selection_rule.save!
      process_cloth_group_selections(@outfit_selection_rule, params[:outfit_selection_rule][:cloth_group_selections] || {})
    end

    flash[:success] = "ルールの登録に成功しました。"
    redirect_to rules_url

    rescue ActiveRecord::RecordInvalid
      #TODO:エラーメッセージで場合分け
      flash[:error] = "ルールの登録に失敗しました。"
      redirect_to new_rule_url
  end

  def show
    @outfit_selection_rule = OutfitSelectionRule.includes(:cloth_groups).find(params[:id])
  end

  def destroy
    @outfit_selection_rule = OutfitSelectionRule.find(params[:id])

    if @outfit_selection_rule.name = "default"
      redirect_to rules_url, alert: "デフォルトのルールは削除できません！"
    else 
    @outfit_selection_rule.destroy
    redirect_to root_url, notice: "ロジックの削除に成功しました！"
    end
  end

  def select_outfit
    @user = current_user
    
    max_temperature = params[:max_temperature]
    min_temperature = params[:min_temperature]
  
    # 数値であることを確認
    unless valid_number?(max_temperature) && valid_number?(min_temperature)
      flash[:error] = "数値を入力してください。"
      redirect_to root_url
      return
    end

    rule_id = find_appropriate_rule_id(max_temperature, min_temperature)
    @selections = find_cloth_group_selections(rule_id)
    session[:selected_clothes_ids] = select_clothes(@selections)
    redirect_to root_url
  end

  private

  def find_appropriate_rule_id(max_temp, min_temp)
    OutfitSelectionRule.where('min_temperature_lower_bound IS NULL OR min_temperature_lower_bound <= ?', min_temp)
                       .where('min_temperature_upper_bound IS NULL OR min_temperature_upper_bound >= ?', min_temp)
                       .where('max_temperature_lower_bound IS NULL OR max_temperature_lower_bound <= ?', max_temp)
                       .where('max_temperature_upper_bound IS NULL OR max_temperature_upper_bound >= ?', max_temp)
                       .order(priority: :asc)
                       .limit(1)
                       .pluck(:id)
                       .first
  end

  def find_cloth_group_selections(rule_id)
    ClothGroupSelection.includes(:cloth_group)
                       .where(outfit_selection_rule_id: rule_id)
                       .map do |selection|
      {
        cloth_group: selection.cloth_group.name,
        selection_count: selection.selection_count
      }
    end
  end

  def select_clothes(selections)
    selections.map do |selection|
      cloth_group = ClothGroup.find_by(name: selection[:cloth_group])
      cloth_type_ids = ClothType.where(cloth_group_id: cloth_group.id).pluck(:id)
      Cloth.where(cloth_type_id: cloth_type_ids)
           .where(user_id: current_user.id)
           .sample(selection[:selection_count]).pluck(:id)
    end.flatten
  end

  def valid_number?(str)
    true if Float(str) rescue false
  end

  def outfit_selection_rule_params
    params.require(:outfit_selection_rule).permit(:name, :description, :priority, 
      :min_temperature_lower_bound, :min_temperature_upper_bound, 
      :max_temperature_lower_bound, :max_temperature_upper_bound,
      cloth_group_selections: {})
  end

  def process_cloth_group_selections(rule, selections_params)
    selections_params.each do |cloth_group_id, selection_count|
      if selection_count.to_i.positive?
        ClothGroupSelection.create!(
          outfit_selection_rule_id: rule.id,
          cloth_group_id: cloth_group_id,
          selection_count: selection_count
        )
      end
    end
  end

  def rule_not_found
    redirect_to root_url, alert: "指定されたルールは存在しませんでした。"
  end
end
