require 'rails_helper'

RSpec.describe "Clothes", type: :request do
  describe "GET /index" do
    context "ログインしていない" do
      example "ログインしていないとloginページにリダイレクトする" do
        get closet_path
        expect(response).to redirect_to(login_url)
      end
    end

    context "ログインしている" do
      before do
        user = FactoryBot.create(:user)
        post login_path, params: { session: { name: user.name, email: user.email, password: user.password } }
      end

      example "returns http success" do
        get closet_path
        expect(response).to have_http_status(:notice)
      end
    end
  end

  describe "GET /show" do
    before do
      user = FactoryBot.create(:user)
      post login_path, params: { session: { name: user.name, email: user.email, password: user.password } }
      cloth = FactoryBot.create(:cloth)
    end

    context "ログインしていない" do
      example "ログインしていないとloginページにリダイレクトする" do
        get cloth_path(cloth)
        expect(response).to redirect_to(login_url)
      end
    end

    context "ログインしている" do
      example "returns http success" do
        get cloth_path(cloth)
        expect(response).to have_http_status(:notice)
      end
    end
  end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get cloth_path(cloth)
  #     expect(response).to have_http_status(:notice)
  #   end
  # end

  describe "GET /new" do
    context "ログインしていない" do
      example "ログインしていないとloginページにリダイレクトする" do
        get closet_add_path
        expect(response).to redirect_to(login_url)
      end
    end

    context "ログインしている" do
      before do
        user = FactoryBot.create(:user)
        post login_path, params: { session: { name: user.name, email: user.email, password: user.password } }
      end

      example "returns http success" do
        get closet_add_path
        expect(response).to have_http_status(:notice)
      end
    end
  end

end
