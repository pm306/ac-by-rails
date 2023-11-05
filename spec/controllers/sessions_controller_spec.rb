require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "DELETE /logout" do
    before do
      @user = FactoryBot.create(:user)
      session[:user_id] = @user.id
    end

    it "ログアウトするとセッションが破棄される" do
      expect(session[:user_id]).to eq(@user.id)
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "ログアウトするとloginにリダイレクトされる" do
      delete :destroy
      expect(response).to redirect_to(login_url)
    end
  end
end
