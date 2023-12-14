class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_no_login, only: [:new]
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  # ユーザーの詳細ページを表示する
  def show; end

  # ユーザーの新規作成フォームを表示する
  def new
    @user = User.new
  end

  # ユーザーの編集フォームを表示する
  def edit; end

  # 新しいユーザーを作成し、成功すればログインページにリダイレクトする
  # 失敗した場合はエラーを表示して新規作成フォームを再表示する
  def create
    @user = User.new(user_create_params)
    if @user.save
      redirect_with_notice(I18n.t('flash.users.create_success'), login_url)
    else
      render_with_alert(@user.errors.full_messages, :new)
    end
  end

  # ユーザー情報を更新する
  # パスワード変更がリクエストされた場合、現在のパスワードの検証を行う
  # 更新が成功すれば編集ページにリダイレクトし、失敗すればエラーを表示する
  def update
    if password_change_requested? && !@user.authenticate(params[:user][:current_password])
      return render_with_alert(I18n.t('flash.users.password_mismatch'), :edit)
    end

    if @user.update(user_update_params)
      redirect_with_notice(I18n.t('flash.users.update_success'), edit_user_path)
    else
      render_with_alert(I18n.t('flash.users.update_failure'), :edit)
    end
  end

  # ユーザーを削除する
  # 削除に成功すればセッションをリセットしてログインページにリダイレクトする
  # 失敗した場合はエラーを表示する
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      reset_session
      redirect_with_notice(I18n.t('flash.users.destroy_success'), login_url)
    else
      render_with_alert(I18n.t('flash.users.destroy_failure'), :edit)
    end
  end

  private

  # 現在のユーザーを設定する
  def set_user
    @user = current_user
  end

  # ユーザー作成時のストロングパラメータ
  def user_create_params
    params.require(:user).permit(:name, :email, :password)
  end

  def user_update_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def password_change_requested?
    params[:user][:password].present?
  end

  def user_not_found
    redirect_with_alert(I18n.t('flash.users.not_found'), root_url)
  end
end
