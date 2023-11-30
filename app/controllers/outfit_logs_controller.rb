class OutfitLogsController < ApplicationController
  before_action :require_login
  rescue_from ActiveRecord::RecordNotFound, with: :log_not_found

  def new
    @outfit_log = OutfitLog.new
    # 他の初期化コード
  end

  def create
    @outfit_log = OutfitLog.new(outfit_log_params)
    if @outfit_log.save
      flash[:notice] = "ログを生成しました。"
      
    else
      flash[:alert] = "ログを生成できませんでした。"
    end
  end

  def index
    @outfit_logs = OutfitLog.includes(:clothes).where(user_id: current_user.id)
  end

  private

  def log_not_found
    redirect_to root_url, alart: "服装のログが取得できませんでした。"
  end

  def outfit_log_params
    params.require(:outfit_log).permit(:date, cloth_ids: [])
  end
end
