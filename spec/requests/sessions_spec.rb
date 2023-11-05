require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /login" do
    let(:user) { FactoryBot.create(:user) }

    context "有効な情報を送信した場合" do
      before do
        post login_path, params: { session: { email: user.email, password: user.password } }
      end

      it "ユーザーがログインする" do
        expect(is_logged_in?).to be_truthy
      end

      it "ユーザーがトップページに遷移する" do
        expect(response).to redirect_to index_path
      end
    end

    context "無効な情報を送信した場合" do
      before do
        post login_path, params: { session: { email: "", password: "" } }
      end

      it "ログインが失敗する" do
        expect(is_logged_in?).to be_falsey
      end

      it "ログインフォームが再表示される" do
        expect(response).to render_template(:new)
      end

      it "適切なエラーメッセージが表示される" do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
