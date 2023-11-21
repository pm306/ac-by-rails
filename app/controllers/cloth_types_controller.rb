class ClothTypesController < ApplicationController
  before_action :require_login, only: [:index, :new, :create]

  def index
    @cloth_types = ClothType.includes(:cloth_group).all
  end

  def new
    @cloth_type = ClothType.new
    @cloth_groups = ClothGroup.all
  end

  def create
    @cloth_type = ClothType.new(cloth_type_create_params)
    if @cloth_type.save
      flash[:success] = "分類を追加できました。"
      redirect_to cloth_types_url
    else
      flash[:error] = "分類を追加できませんでした。"
      redirect_to new_cloth_type_url
    end
  end

  def cloth_type_create_params
    params.require(:cloth_type).permit(:name, :cloth_group_id)
  end
end