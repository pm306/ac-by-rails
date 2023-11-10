user = User.find_or_create_by(email: "oyama306@onimai.com") do |u|
    u.name = "緒山まひろ"
    u.password = "password"
    u.password_confirmation = "password"
  end
  
cloth_types = [
  { type_name: 'Jeans', category: 1 },
  { type_name: 'T-Shirt', category: 0 }
  # 他の種類を追加...
]

cloth_types.each do |type|
    ClothType.find_or_create_by(type)
end

image_path = Rails.root.join("app/assets/images/seeds/sample.png")

cloths = [
    {user_id: user.id, description: "sample data", last_worn_on: Date.parse('2000-01-01'),cloth_type_id: 1}
]

cloths.each do |cloth_data|
    #Cloth.find_or_create_by(cloth)
    cloth = Cloth.new(cloth_data)
    cloth.image.attach(io: File.open(image_path), filename: 'sample.png', content_type: 'image/png')
    cloth.save
end