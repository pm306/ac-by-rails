class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  private
  def user_params
    # Strong Parametersを使用して安全にパラメータをフィルタリングする
    params.require(:user).permit(:name, :email, :password)
  end
end
