class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)
    if @user.save
      flash[:success] = "ユーザー登録に成功しました！"
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    # パスワード変更の処理
    if password_change_requested?
      unless @user.authenticate(params[:user][:current_password])
        # 現在のパスワードが一致しない場合のエラー処理
        flash[:error] = "現在のパスワードが一致しません"
        return render :edit
      end

      unless params[:user][:password] == params[:user][:password_confirmation]
        # 新しいパスワードとその確認が一致しない場合のエラー処理
        flash[:error] = "新しいパスワードが一致しません"
        return render :edit
      end
    end

    # 名前の更新
    if @user.update(user_update_params)
      # 更新成功時の処理（リダイレクトなど）
      flash[:success] = "更新に成功しました"
      redirect_to edit_user_path
    else
      flash[:error] = "更新に失敗しました"
      render :edit
    end    
  end

  private

  def user_create_params
    # Strong Parametersを使用して安全にパラメータをフィルタリングする
    params.require(:user).permit(:name, :email, :password)
  end

  def user_update_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def password_change_requested?
    params[:user][:password].present?
  end
end
