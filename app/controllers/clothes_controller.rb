class ClothesController < ApplicationController
  before_action :require_login, only: [:index, :new, :create]

  def index
  end

  def new
    @cloth = Cloth.new
  end

  def create
    @cloth = Cloth.new(cloth_params)
    @cloth.user_id = current_user.id
    @cloth.last_worn_on = Date.parse('2000-01-01')
    if @cloth.save
      flash[:success] = "服が登録されました"
      redirect_to closet_add_path
    else
      flash.now[:error] = "服の登録に失敗しました"
      render :new
    end
  end

  def show
  end

  private
  def cloth_params
    params.require(:cloth).permit(:image, :cloth_type_id, :description)
  end
end
