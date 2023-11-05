require 'rails_helper'

RSpec.feature "ページ遷移のテスト", type: :feature do
    scenario "ログイン→ユーザー登録に遷移する" do
        visit login_path
        click_link "ユーザー登録"
        expect(current_path).to eq(signup_path)
    end

    #遷移先のトップページが未実装なのでコメントアウト
    # scenario "ユーザー登録→トップに遷移する" do
    #     visit login_path
    #     click_link "戻る"
    #     expect(current_path).to eq(signup_path)
    # end    
end

