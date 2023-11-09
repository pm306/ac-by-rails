require 'rails_helper'

RSpec.describe ClothesController, type: :controller do
    before do
        allow(controller).to receive(:current_user).and_return(user)
    end
      
    describe "POST #create" do
        
        let(:user) { FactoryBot.create(:user) }
        let(:cloth_type) { FactoryBot.create(:cloth_type) }
        let(:image) { fixture_file_upload(Rails.root.join('spec/fixtures/images/test_image.png'), 'image/png') }

        let(:valid_attributes) do
            {
                cloth_type_id: cloth_type.id,
                description: "nekopanchi",
                image: image
            }
        
        end

        context "有効なパラメータが送信される場合" do
            example "新しい服インスタンスが生成される" do
                expect {
                    post :create, params: { cloth: valid_attributes }
                }.to change(Cloth, :count).by(1)
            end
        end
    end
end
