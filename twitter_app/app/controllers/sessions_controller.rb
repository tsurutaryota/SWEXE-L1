class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(uid: params[:uid])

    if user && BCrypt::Password.new(user.pass) == params[:pass]
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました。"
    else
      flash.now[:alert] = "UIDまたはパスワードが違います。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "ログアウトしました。"
  end
end
