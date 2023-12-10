class ClothTypesController < ApplicationController
  before_action :require_login, only: %i[index new create destroy]
  before_action :set_cloth_groups, only: %i[new create]
  rescue_from ActiveRecord::RecordNotFound, with: :cloth_type_not_found

  def index
    @cloth_types = ClothType.includes(:cloth_group).all
  end

  def new
    @cloth_type = ClothType.new
  end

  def create
    @cloth_type = ClothType.new(cloth_type_create_params)
    if @cloth_type.save
      redirect_with_notice(I18n.t('flash.cloth_types.create_success'), cloth_types_url)
    else
      render_with_alert(I18n.t('flash.cloth_types.create_failure'), :new)
    end
  end

  def destroy
    @cloth_type = ClothType.find(params[:id])
    @cloth_type.destroy
    redirect_with_notice(I18n.t('flash.cloth_types.destroy_success'), cloth_type_url)
  end

  private

  def cloth_type_create_params
    params.require(:cloth_type).permit(:name, :cloth_group_id)
  end

  def set_cloth_groups
    @cloth_groups = ClothGroup.all
  end

  def cloth_type_not_found
    redirect_with_alert(I18n.t('flash.cloth_types.not_found'), cloth_url)
  end
end
