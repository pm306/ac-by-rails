require 'rails_helper'

RSpec.feature 'ページ遷移のテスト', type: :feature do
  context 'ログインが必要ケース' do
    before do
      user = FactoryBot.create(:user, name: 'mahiro', email: 'oyama306@onimai.com', password: 'password')
      visit login_path
      fill_in 'session[email]', with: 'oyama306@onimai.com'
      fill_in 'session[password]', with: 'password'
      click_button 'ログイン'
    end

    scenario 'メインページ→クローゼットに遷移する' do
      visit root_path
      click_link 'クローゼットへ'
      expect(current_path).to eq(closet_path)
    end

    scenario 'クローゼット→メインページに遷移する' do
      visit closet_path
      click_link '戻る'
      expect(current_path).to eq(root_path)
    end

    scenario 'クローゼットから服追加ページに遷移する' do
      visit closet_path
      click_link '服を追加する'
      expect(current_path).to eq(closet_add_path)
    end

    scenario '服追加ページからクローゼットに遷移する' do
      visit closet_add_path
      click_link '戻る'
      expect(current_path).to eq(closet_path)
    end
  end

  context '非ログインであるべきケース' do
    scenario 'ログイン→ユーザー登録に遷移する' do
      visit login_path
      click_link 'ユーザー登録'
      expect(current_path).to eq(signup_path)
    end

    scenario 'ユーザー登録→ログインに遷移する' do
      visit signup_path
      click_link '戻る'
      expect(current_path).to eq(login_path)
    end
  end
end
