class OutfitSelector
  def initialize(user)
    @user = user
  end

  # ユーザー入力とルールに基づいて服装を選択する
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

  # 与えられた気温に基づいて適用するルールidを取得する
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
  # それらの各レコードから服グループの名前と選択回数を含むハッシュの配列を返す
  #
  # @param rule_id [Integer] 検索するOutfitSelectionRuleのID
  # @return [Array<Hash>] 以下のキーを含むハッシュの配列:
  #   - :cloth_group_id [String] 服グループのid
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

  # 特定の服グループIDに対応する服タイプIDの配列を取得する
  #
  # @param [Integer] cloth_group_id 服グループのID
  # @return [Array<Integer>, nil] 服タイプIDの配列、または服グループが存在しない場合はnil
  def find_cloth_type_ids_for_group(cloth_group_id)
    cloth_group = ClothGroup.find_by(id: cloth_group_id)
    ClothType.where(cloth_group_id: cloth_group.id).pluck(:id) if cloth_group
  end

  # 与えられた服タイプIDのセットに基づいてランダムに服を選択する
  #
  # @param [Array<Integer>] cloth_type_ids 服タイプIDの配列
  # @param [Integer] selection_count 選択する服の枚数
  # @return [Array<Integer>] 選択された服のIDの配列
  def select_clothes_for_types(cloth_type_ids, selection_count)
    Cloth.where(cloth_type_id: cloth_type_ids)
         .where(user_id: @user.id)
         .where('last_worn_on IS NULL OR last_worn_on < ?', Date.yesterday)
         .sample(selection_count).pluck(:id)
  end

  # 与えられた選択肢に基づいて服をランダムに選択する
  #
  # @param [Array<Hash>] selections 選択肢の配列（各ハッシュは :cloth_group_id と :selection_count を含む）
  # @return [Array<Integer>] 選択された服のIDの配列
  def select_clothes_ids(selections)
    selections.map do |selection|
      cloth_type_ids = find_cloth_type_ids_for_group(selection[:cloth_group_id])
      select_clothes_for_types(cloth_type_ids, selection[:selection_count]) if cloth_type_ids
    end.compact.flatten
  end
end
