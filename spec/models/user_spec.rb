require 'rails_helper'

RSpec.describe User, type: :model do
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

  # nameが17文字以上で無効であることを確認する
  it 'nameが17文字以上で無効' do
    user = User.new(valid_attributes.merge(name: 'a' * 17))
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 16 characters)")
  end

  # emailが空の場合に無効であることを確認する
  it 'is invalid without an email' do
    user = User.new(valid_attributes.merge(email: ''))
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # emailが不正な形式の場合に無効であることを確認する
  it 'is invalid with an incorrect email format' do
    user = User.new(valid_attributes.merge(email: 'user_at_foo.org'))
    user.valid?
    expect(user.errors[:email]).to include('is invalid')
  end

  # passwordが空の場合に無効であることを確認する
  it 'is invalid without a password' do
    user = User.new(valid_attributes.merge(password: ''))
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
end
