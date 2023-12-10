class OutfitSelector
  def initialize(user)
    @user = user
  end

  def select_outfit(max_temperature, min_temperature)
    rule_id = find_appropriate_rule_id(max_temperature, min_temperature)
    selections = find_cloth_group_selections(rule_id)
    select_clothes(selections)
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
           .where('last_worn_on IS NULL OR last_worn_on < ?', Date.yesterday)
           .sample(selection[:selection_count]).pluck(:id)
    end.flatten
  end

end