# == Schema Information
#
# Table name: cloth_types
#
#  id             :bigint           not null, primary key
#  name           :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cloth_group_id :bigint
#
# Indexes
#
#  index_cloth_types_on_cloth_group_id  (cloth_group_id)
#  index_cloth_types_on_name            (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (cloth_group_id => cloth_groups.id)
#
require 'rails_helper'

RSpec.describe ClothType, type: :model do
  let(:cloth_type) { FactoryBot.create(:cloth_type) }
  let(:user) { FactoryBot.create(:user) }
  let(:cloth) { FactoryBot.create(:cloth) }

  describe 'バリデーションチェック' do
    example 'バリデーションが有効である' do
      expect(cloth_type).to be_valid
    end

    example 'type_nameが空のとき無効である' do
      cloth_type.type_name = nil
      expect(cloth_type).not_to be_valid
    end

    example '同じtype_nameが既に存在しているとき無効である' do
      FactoryBot.create(:cloth_type, type_name: 'nekodesu', category: :outerwear)
      duplicate_cloth_type = FactoryBot.build(:cloth_type, type_name: 'nekodesu', category: :tops)
      duplicate_cloth_type.valid?
      expect(duplicate_cloth_type.errors[:type_name]).to include('has already been taken')
    end
  end

  describe 'enums' do
    example 'category enumが定義されている' do
      expect(ClothType.categories).to eq({ 'tops' => 0, 'bottoms' => 1, 'outerwear' => 2, 'other' => 3 })
    end
  end

  describe 'アソシエーション' do
    example 'has many cloths' do
      expect(cloth_type).to respond_to(:cloths)
    end
  end
end
