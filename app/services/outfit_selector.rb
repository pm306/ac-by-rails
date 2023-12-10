class OutfitSelector
  def initialize(user)
    @user = user
  end

  # 服を選択するビジネスロジック
  #
  # @param max_temprature [Integer] リクエストから受け取った最高気温
  # @param min_temprature [Integer] リクエストから受け取った最低気温
  # @return [array] 選択された服のidの配列
  def select_outfit(max_temperature, min_temperature)
    rule_id = find_appropriate_rule_id(max_temperature, min_temperature)
    selections = find_cloth_group_selections(rule_id)
    select_clothes_ids(selections)
  end

  private

  # 適用するルールidを取得する
  #
  # @param max_temp [Integer] リクエストから受け取った最高気温
  # @param min_temp [Integer] リクエストから受け取った最低気温
  # @return [Integer] 適用するルールのid
  def find_appropriate_rule_id(max_temp, min_temp)
    OutfitSelectionRule
    .where('min_temperature_lower_bound IS NULL OR min_temperature_lower_bound <= ?', min_temp)
    .where('min_temperature_upper_bound IS NULL OR min_temperature_upper_bound >= ?', min_temp)
    .where('max_temperature_lower_bound IS NULL OR max_temperature_lower_bound <= ?', max_temp)
    .where('max_temperature_upper_bound IS NULL OR max_temperature_upper_bound >= ?', max_temp)
    .order(priority: :asc)
    .limit(1)
    .pluck(:id)
  end

  # 与えられたルールIDに基づきClothGroupSelectionレコードを検索し、
  # それらの各レコードから服グループの名前と選択回数を含むハッシュの配列を返す。
  #
  # @param rule_id [Integer] 検索するOutfitSelectionRuleのID
  # @return [Array<Hash>] 以下のキーを含むハッシュの配列:
  #   - :cloth_group [String] 服グループのid
  #   - :selection_count [Integer] 選択回数
  def find_cloth_group_selections(rule_id)
    ClothGroupSelection.includes(:cloth_group)
                       .where(outfit_selection_rule_id: rule_id)
                       .map do |selection|
      {
        cloth_group_id: selection.cloth_group_id,
        selection_count: selection.selection_count
      }
    end
  end

  # グループごとに服を決められた枚数だけランダム選択する
  def select_clothes_ids(selections)
    selections.map do |selection|
      cloth_group = ClothGroup.find_by(id: selection[:cloth_group_id])
      cloth_type_ids = ClothType.where(cloth_group_id: cloth_group.id).pluck(:id)
      Cloth.where(cloth_type_id: cloth_type_ids)
           .where(user_id: @user.id)
           .where('last_worn_on IS NULL OR last_worn_on < ?', Date.yesterday)
           .sample(selection[:selection_count]).pluck(:id)
    end.flatten
  end
end
