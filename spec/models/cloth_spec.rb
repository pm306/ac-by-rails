require 'rails_helper'

RSpec.describe Cloth, type: :model do
  
  let(:cloth) { FactoryBot.create(:cloth) }

  describe "バリデーションチェック" do
    example "バリデーションが有効である" do
      expect(cloth).to be_valid
    end

    example "user_idが空なら無効である" do
      cloth.user_id = nil
      expect(cloth).not_to be_valid
    end

    example "last_worn_onが空なら無効である" do
      cloth.last_worn_on = nil
      expect(cloth).not_to be_valid
    end

    example "last_worn_onが日付型ではない" do
      cloth.last_worn_on = "not-date"
      expect(cloth).not_to be_valid
    end

    example "cloth_type_idが空なら無効である" do
      cloth.cloth_type_id = nil
      expect(cloth).not_to be_valid
    end

    #TODO: 画像ファイルに関するテストの追加
  end

  describe "アソシエーション" do
    example "Userと関連している" do
      expect(cloth).to respond_to(:user)
    end

    example "Cloth_typeと関連している" do
      expect(cloth).to respond_to(:cloth_type)
    end
  end

  describe "メソッド" do
    example "last_worn_onがdate型であるか調べる" do
      expect(cloth.last_worn_on).to be_a(Date)
    end

  end
end
