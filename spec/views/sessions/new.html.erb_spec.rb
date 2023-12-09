require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :view do
  example 'ログインフォームが正しくレンダリングされている' do
    render

    assert_select 'form[action=?][method=?]', sessions_path, 'post' do
      assert_select 'input[name=?]', 'session[email]'
      assert_select 'input[name=?]', 'session[password]'
      assert_select 'input[type=?]', 'submit'
    end
  end
end
