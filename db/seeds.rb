ActiveStorage::AnalyzeJob.queue_adapter = :inline
ActiveStorage::PurgeJob.queue_adapter = :inline

user = User.find_or_create_by(email: "example@guest.com") do |u|
  u.name = "ゲスト太郎"
  u.password = "password"
  u.password_confirmation = "password"
end

cloth_groups = [
  { name: "半袖（外）"},
  { name: "半袖（内）"},
  { name: "長袖（薄）"},
  { name: "長袖（厚）"},
  { name: "アウター"},
  { name: "ボトムス（薄）"},
  { name: "ボトムス（厚）"},
]

cloth_groups.each do |group|
  ClothGroup.find_or_create_by(group)
end
  
cloth_types = [
  { name: "Tシャツ",    cloth_group_id: 1 },
  { name: "長袖シャツ", cloth_group_id: 3 },
  { name: "パーカー",   cloth_group_id: 4 },
  { name: "ジーンズ(薄)",   cloth_group_id: 6 },
  { name: "ジーンズ(厚)", cloth_group_id: 7},
  { name: "アウター",   cloth_group_id: 5 },
  # 他の種類を追加...
]

cloth_types.each do |type|
  ClothType.find_or_create_by(type)
end

cloths = [
  { user_id: user.id, cloth_type_id: 1, description: "Tシャツの説明",   last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/tshirt.png") },
  { user_id: user.id, cloth_type_id: 2, description: "長袖シャツの説明",last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/longsleeve.png") },
  { user_id: user.id, cloth_type_id: 3, description: "パーカーの説明",  last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/hoodie.png") },
  { user_id: user.id, cloth_type_id: 4, description: "ジーンズの説明",  last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/jeans.png") },
  { user_id: user.id, cloth_type_id: 5, description: "ジーンズ2の説明", last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/jeans2.png") },
  { user_id: user.id, cloth_type_id: 6, description: "アウターの説明",  last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/outer.png") },
]

cloths.each do |cloth_data|
  next if Cloth.exists?(description: cloth_data[:description])

  cloth = Cloth.new(cloth_data.except(:image_path))
  image_path = cloth_data[:image_path]
  cloth.image.attach(io: File.open(image_path), filename: File.basename(image_path), content_type: 'image/png')
  cloth.save!
end

# 服装選択ルールの作成（既存のルールがない場合のみ）

# 夏用ルール
summer_rule = OutfitSelectionRule.find_or_create_by(name: '夏用') do |rule|
  rule.description = ''
  rule.priority = 1
  rule.min_temperature_lower_bound = 20
end

# 冬用ルール
winter_rule = OutfitSelectionRule.find_or_create_by(name: '冬用') do |rule|
  rule.description = ''
  rule.priority = 2
  rule.max_temperature_upper_bound = 15
end

# その他のルール
other_rule = OutfitSelectionRule.find_or_create_by(name: 'その他') do |rule|
  rule.description = 'いずれのルールにもマッチしなかった時に選ばれる'
  rule.priority = 50
end

# ClothGroupSelectionの作成（既存の選択肢がない場合のみ）

# 夏用ルールでグループ1と6を選択
[ClothGroup.find_by(name: "半袖（外）"), ClothGroup.find_by(name: "ボトムス（薄）")].each do |group|
  ClothGroupSelection.find_or_create_by(outfit_selection_rule: summer_rule, cloth_group: group) do |selection|
    selection.selection_count = 1
  end
end

# 冬用ルールでグループ2, 3, 4, 5, 7を選択
["半袖（内）", "長袖（薄）", "長袖（厚）", "アウター", "ボトムス（厚）"].each do |group_name|
  group = ClothGroup.find_by(name: group_name)
  ClothGroupSelection.find_or_create_by(outfit_selection_rule: winter_rule, cloth_group: group) do |selection|
    selection.selection_count = 1
  end
end

# その他のルールでグループ1, 3, 6を選択
["半袖（外）", "長袖（薄）", "ボトムス（厚）"].each do |group_name|
  group = ClothGroup.find_by(name: group_name)
  ClothGroupSelection.find_or_create_by(outfit_selection_rule: other_rule, cloth_group: group) do |selection|
    selection.selection_count = 1
  end
end