class ClothesController < ApplicationController
  before_action :require_login, only: [:index, :new, :create, :show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :cloth_not_found

  def index
    base_query = current_user.clothes

    if params[:types].present?
      @clothes = base_query.where(cloth_type_id: params[:types])
    else
      @clothes = Cloth.none
    end
  end

  def new
    @cloth = Cloth.new
  end

  def create
    @cloth = Cloth.new(cloth_params)
    @cloth.user_id = current_user.id
    @cloth.last_worn_on = Date.parse('2000-01-01')
    if @cloth.save
      flash[:notice] = "服が登録されました"
      redirect_to closet_add_url
    else
      flash[:alert] = "服の登録に失敗しました"
      redirect_to closet_add_url
    end
  end

  def show
    @cloth = Cloth.find(params[:id])
  end

  def update
    # 決定ボタンが押された場合の処理
    if params[:selected_clothes_ids].present?
      selected_clothes_ids = params[:selected_clothes_ids].split(',')
      selected_clothes_ids.each do |id|
        cloth = Cloth.find(id)
        cloth.update(last_worn_on: Date.today)
      end

      redirect_to deside_url
    end
  end

  def destroy
    @cloth = Cloth.find(params[:id])
    @cloth.destroy
    redirect_to closet_path, notice: "服が削除されました"
  end

  private
  def cloth_params
    params.require(:cloth).permit(:image, :cloth_type_id, :description)
  end

  def cloth_not_found
    redirect_to closet_url, alert: '指定された服は見つかりませんでした。'
  end
end
