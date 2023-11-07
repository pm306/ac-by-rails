require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    before do
      # 事前にユーザーを1つ作成しておきます
      FactoryBot.create(:user)
    end

    # 有効なユーザーの属性
    let(:valid_attributes) {
      { name: 'Example User', email: 'user@example.com', password: 'password' }
    }

    it 'ユーザーが有効' do
      user = User.new(valid_attributes)
      expect(user).to be_valid
    end

    # nameが空の場合に無効であることを確認する
    it 'is invalid without a name' do
      user = User.new(valid_attributes.merge(name: ''))
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    example 'nameが17文字以上で無効' do
      user = User.new(valid_attributes.merge(name: 'a' * 17))
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 16 characters)")
    end

    # emailが空の場合に無効であることを確認する
    example 'emailの入力が空だと無効' do
      user = User.new(valid_attributes.merge(email: ''))
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end


    example "emailの入力形式が正しくないと無効" do
      user = User.new(valid_attributes.merge(email: 'umauma_onigiri'))
      user.valid?
      expect(user.errors[:email]).to include('is invalid')
    end

    example "登録済みのメールアドレスは無効である" do
      user = FactoryBot.build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    # passwordが空の場合に無効であることを確認する
    it 'is invalid without a password' do
      user = User.new(valid_attributes.merge(password: ''))
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end
