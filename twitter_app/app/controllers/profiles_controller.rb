class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to profile_path, notice: "プロフィールを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_login
    unless session[:user_id] && User.exists?(id: session[:user_id])
      redirect_to login_path, alert: "ログインしてください。"
    end
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def profile_params
    params.require(:user).permit(:name, :bio)
  end
end
