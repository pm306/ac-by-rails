require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /signup' do
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:notice)
    end
  end

  describe 'POST /signup' do
    context 'リクエストに有効なパラメータがある' do
      example '新規ユーザーが作成される' do
        expect do
          post users_path, params: { user: { name: 'userman', email: 'user@example.com', password: 'password' } }
        end.to change(User, :count).by(1)
      end
    end

    context 'リクエストに無効なパラメータがある' do
      example '新規ユーザーが作成されない' do
        expect do
          post users_path, params: { user: { name: '', email: 'user@example.com', password: 'password' } }
        end.not_to change(User, :count)
      end
    end
  end
end
