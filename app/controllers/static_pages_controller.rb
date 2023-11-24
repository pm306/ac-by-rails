class StaticPagesController < ApplicationController
  before_action :require_login, only: [:home, :deside]

  def home
    @user = current_user
  end

  def deside
  end
end
