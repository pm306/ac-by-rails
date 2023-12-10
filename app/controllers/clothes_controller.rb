class ClothesController < ApplicationController
  before_action :require_login, only: %i[index new create show edit update update_deside destroy]
  before_action :set_cloth, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :cloth_not_found

  def index
    @clothes = if params[:types].present?
                 current_user.clothes.where(cloth_type_id: params[:types])
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
    @cloth = Cloth.new(cloth_params)
    @cloth.user_id = current_user.id
    @cloth.last_worn_on = Date.parse('2000-01-01')
    if @cloth.save
      redirect_with_notice(I18n.t('flash.clothes.create_success'), new_cloth_url)
    else
      render_with_alert(I18n.t('flash.clothes.create_failure'), :new)
    end
  end

  def update
    if @cloth.update(cloth_params)
      redirect_with_notice(I18n.t('flash.clothes.update_success'), cloth_url(@cloth))
    else
      render_with_alert(I18n.t('flash.clothes.update_failure'), :edit)
    end
  end

  def update_deside
    return unless params[:selected_clothes_ids].present?

    selected_clothes_ids = params[:selected_clothes_ids].split(',')
    Cloth.update_last_worn(selected_clothes_ids)
    OutfitLog.create_outfit_log(current_user, selected_clothes_ids)
    redirect_to deside_url
  end

  def destroy
    @cloth.soft_delete
    redirect_with_notice(I18n.t('flash.clothes.destroy_success'), closet_url)
  end

  private

  def set_cloth
    @cloth = Cloth.find(params[:id])
  end

  def cloth_params
    params.require(:cloth).permit(:name, :description, :cloth_type_id, :image)
  end

  def cloth_not_found
    redirect_with_alert(I18n.t('flash.clothes.not_found'), clothes_url)
  end
end
