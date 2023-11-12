user = User.find_or_create_by(email: "oyama306@onimai.com") do |u|
  u.name = "緒山まひろ"
  u.password = "password"
  u.password_confirmation = "password"
end
  
cloth_types = [
  { type_name: "Tシャツ", category: 0 },
  { type_name: "長袖シャツ", category: 0},
  { type_name: "パーカー", category: 0},
  { type_name: "ジーンズ", category: 1 },
  { type_name: "アウター", category: 2},
  { type_name: "その他", category: 3},
  # 他の種類を追加...
]

cloth_types.each do |type|
  ClothType.find_or_create_by(type)
end

cloths = [
  { user_id: user.id, cloth_type_id: 1, description: "Tシャツの説明", last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/tshirt.png") },
  { user_id: user.id, cloth_type_id: 2, description: "長袖シャツの説明",last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/longsleeve.png") },
  { user_id: user.id, cloth_type_id: 3, description: "パーカーの説明",last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/hoodie.png") },
  { user_id: user.id, cloth_type_id: 4, description: "ジーンズの説明",last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/jeans.png") },
  { user_id: user.id, cloth_type_id: 5, description: "アウターの説明",last_worn_on: Date.parse('2000-01-01'), image_path: Rails.root.join("app/assets/images/seeds/outer.png") },
]

cloths.each do |cloth_data|
  next if Cloth.exists?(description: cloth_data[:description])

  cloth = Cloth.new(cloth_data.except(:image_path))
  image_path = cloth_data[:image_path]
  cloth.image.attach(io: File.open(image_path), filename: File.basename(image_path), content_type: 'image/png')
  cloth.save!
end