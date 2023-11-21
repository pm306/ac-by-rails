class StaticPagesController < ApplicationController
  before_action :require_login, only: [:home]

  def home
    @user = current_user
  end
end
