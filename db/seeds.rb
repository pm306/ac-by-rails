User.create!(name: "緒山まひろ", email: "oyama306@onimai.com", password: "password", password_confirmation: "password")

cloth_types = [
  { type_name: 'Jeans', category: 1 },
  { type_name: 'T-Shirt', category: 0 }
  # 他の種類を追加...
]

cloth_types.each do |type|
    ClothType.find_or_create_by(type)
end

cloths = [
    {user_id: 1, description: "sample data", last_worn_on: Date.parse('2000-01-01'),type_name: "Jeans"}
]

cloths.each do |cloth|
    Cloth.find_or_create_by(cloth)
end