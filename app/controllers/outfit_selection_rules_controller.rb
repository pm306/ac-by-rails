class OutfitSelectionRulesController < ApplicationController
  before_action :require_login, only: [:index, :new, :create, :show, :select_outfit]

  def index
    @outfit_selection_rules = OutfitSelectionRule.all
  end

  def new
    @outfit_selection_rule = OutfitSelectionRule.new
    @cloth_groups = ClothGroup.all
  end

  def create
    @outfit_selection_rule = OutfitSelectionRule.new(outfit_selection_rule_params)
    if @outfit_selection_rule.save
      flash[:success] = "ルールが正常に作成されました。"
      redirect_to rules_url
    else
      flash[:error] = "ルールの登録に失敗しました。"
      redirect_to rules_url
    end
  end

  def show
    @outfit_selection_rule = OutfitSelectionRule.includes(:cloth_groups).find(params[:id])
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
      Cloth.where(cloth_type_id: cloth_type_ids).sample(selection[:selection_count]).pluck(:id)
    end.flatten
  end

  def valid_number?(str)
    true if Float(str) rescue false
  end

  def outfit_selection_rule_params
    params.require(:outfit_selection_rule).permit(:name, :description, :priority, 
      :min_temperature_lower_bound, :min_temperature_upper_bound, 
      :max_temperature_lower_bound, :max_temperature_upper_bound)
  end
end
