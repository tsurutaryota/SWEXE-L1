class UsersController < ApplicationController
  before_action :require_login, only: [:destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    password_confirmation = params.dig(:user, :password_confirmation)

    if @user.pass != password_confirmation
      @user.errors.add(:pass, "と確認用パスワードが一致しません")
      render :new, status: :unprocessable_entity
      return
    end

    if @user.valid?
      @user.pass = BCrypt::Password.create(@user.pass)
      @user.save!
      redirect_to users_path, notice: "ユーザーを登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.id == session[:user_id]
      @user.destroy
      reset_session
      redirect_to login_path, notice: "ユーザーを削除しました。"
    else
      redirect_to users_path, alert: "自分のアカウントのみ削除できます。"
    end
  end

  private

  def require_login
    unless session[:user_id] && User.exists?(id: session[:user_id])
      redirect_to login_path, alert: "ログインしてください。"
    end
  end

  def user_params
    params.require(:user).permit(:uid, :pass)
  end
end
