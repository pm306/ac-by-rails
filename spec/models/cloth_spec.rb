# == Schema Information
#
# Table name: clothes
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  description   :text(65535)
#  last_worn_on  :date             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cloth_type_id :integer
#  user_id       :integer          not null
#
# Indexes
#
#  index_clothes_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Cloth, type: :model do
  let(:cloth) { FactoryBot.create(:cloth) }

  describe 'バリデーションチェック' do
    example 'バリデーションが有効である' do
      expect(cloth).to be_valid
    end

    example 'user_idが空なら無効である' do
      cloth.user_id = nil
      expect(cloth).not_to be_valid
    end

    example 'last_worn_onが空なら無効である' do
      cloth.last_worn_on = nil
      expect(cloth).not_to be_valid
    end

    example 'last_worn_onが日付型ではない' do
      cloth.last_worn_on = 'not-date'
      expect(cloth).not_to be_valid
    end

    example 'cloth_type_idが空なら無効である' do
      cloth.cloth_type_id = nil
      expect(cloth).not_to be_valid
    end

    example '画像が登録されていなければ無効である' do
      cloth.image.purge
      expect(cloth.image).not_to be_attached
    end
  end

  describe 'アソシエーション' do
    example 'Userと関連している' do
      expect(cloth).to respond_to(:user)
    end

    example 'Cloth_typeと関連している' do
      expect(cloth).to respond_to(:cloth_type)
    end
  end

  describe 'メソッド' do
    example 'last_worn_onがdate型であるか調べる' do
      expect(cloth.last_worn_on).to be_a(Date)
    end
  end
end
