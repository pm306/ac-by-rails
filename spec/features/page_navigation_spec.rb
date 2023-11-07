require 'rails_helper'

RSpec.feature "ページ遷移のテスト", type: :feature do

    let(:user) {FactoryBot.create(:user) }

    scenario "ログイン→ユーザー登録に遷移する" do
        visit login_path
        click_link "ユーザー登録"
        expect(current_path).to eq(signup_path)
    end

    scenario "ユーザー登録→ログインに遷移する" do
        visit signup_path
        click_link "戻る"
        expect(current_path).to eq(login_path)
    end
    
    # ログイン処理が必要なので単体テストには向いてないかもしれない
    # 統合テストとして実装するべき？
    # scenario "メインページ→クローゼットに遷移する" do
        
    #     visit root_path
    #     click_link "クローゼットへ"
    #     expect(current_path).to eq(closet_path)
    # end

    # scenario "クローゼット→メインページに遷移する" do
    #     visit closet_path
    #     click_link "戻る"
    #     expect(current_path).to eq(root_path)
    # end
end
