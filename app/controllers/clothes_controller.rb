class ClothesController < ApplicationController
  before_action :require_login, only: %i[index new create show edit update update_deside destroy]
  before_action :set_cloth, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :cloth_not_found

  def index
    base_query = current_user.clothes

    @clothes = if params[:types].present?
                 base_query.where(cloth_type_id: params[:types])
               else
                 Cloth.none
               end
  end

  def show; end

  def new
    @cloth = Cloth.new
  end

  def edit; end

  def create
    @cloth = Cloth.new(cloth_create_params)
    @cloth.user_id = current_user.id
    @cloth.last_worn_on = Date.parse('2000-01-01')
    if @cloth.save
      flash[:notice] = '服が登録されました'
      redirect_to closet_add_url
    else
      flash[:alert] = '服の登録に失敗しました'
      redirect_to closet_add_url
    end
  end

  def update
    if @cloth.update(cloth_update_params)
      redirect_to cloth_url(@cloth), notice: '更新しました'
    else
      render :edit, alert: '更新に失敗しました'
    end
  end

  def update_deside
    return unless params[:selected_clothes_ids].present?

    selected_clothes_ids = params[:selected_clothes_ids].split(',')

    selected_clothes_ids.each do |id|
      cloth = Cloth.find(id)
      cloth.update(last_worn_on: Date.today)
    end

    outfit_log = OutfitLog.new(user: current_user, date: Date.today)
    selected_clothes_ids.each do |cloth_id|
      outfit_log.outfit_logs_clothes.build(cloth_id:)
    end
    outfit_log.save

    redirect_to deside_url
  end

  def destroy
    @cloth.soft_delete
    redirect_to closet_path, notice: '服が削除されました'
  end

  private

  def set_cloth
    @cloth = Cloth.find(params[:id])
  end

  def cloth_create_params
    params.require(:cloth).permit(:image, :cloth_type_id, :description)
  end

  def cloth_update_params
    params.require(:cloth).permit(:image, :description, :last_worn_on, :cloth_type_id)
  end

  def cloth_not_found
    redirect_to closet_url, alert: '指定された服は見つかりませんでした。'
  end
end
