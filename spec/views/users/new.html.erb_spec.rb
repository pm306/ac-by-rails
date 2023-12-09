require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  before do
    assign(:user, User.new) # 新しいUserインスタンスをビューに渡す
  end

  it 'ユーザー登録フォームが正しくレンダリングされている' do
    render

    assert_select 'form[action=?][method=?]', users_path, 'post' do
      assert_select 'input[name=?]', 'user[name]'
      assert_select 'input[name=?]', 'user[email]'
      assert_select 'input[name=?]', 'user[password]'
      assert_select 'input[type=?]', 'submit'
    end
  end
end
