require 'rails_helper'

RSpec.describe "Main", type: :request do
  describe "GET /new" do
    context "非ログイン" do
      it "ログインしていないとloginページにリダイレクトする" do
        get root_path
        expect(response).to redirect_to(login_url)
      end
    end

    context "ログインしている" do
      before do
        user = FactoryBot.create(:user)
        post login_path, params: { session: { name: user.name, email: user.email, password: user.password } }
      end

      it "リダイレクトせずにアクセスできる" do
        get root_path
        expect(response).to have_http_status(:notice)
      end
    end
  end
end
