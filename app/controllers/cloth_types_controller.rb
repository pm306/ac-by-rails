class ClothTypesController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @cloth_types = ClothType.includes(:cloth_group).all
  end
end