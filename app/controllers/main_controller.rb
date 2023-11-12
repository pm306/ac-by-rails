class MainController < ApplicationController
  before_action :require_login, only: [:new, :recommend]

  def new
  end

  def recommend
  end
end
