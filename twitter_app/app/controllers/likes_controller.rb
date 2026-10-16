class LikesController < ApplicationController
  before_action :require_login

  def create
    tweet = Tweet.find(params[:tweet_id])
    like = Like.find_or_initialize_by(
      user_id: session[:user_id],
      tweet_id: tweet.id
    )

    if like.new_record?
      like.save
    end

    redirect_to root_path, notice: "いいねしました。"
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    like = Like.find_by(
      id: params[:id],
      user_id: session[:user_id],
      tweet_id: tweet.id
    )

    like&.destroy
    redirect_to root_path, notice: "いいねを取り消しました。"
  end

  private

  def require_login
    unless session[:user_id] && User.exists?(id: session[:user_id])
      redirect_to login_path, alert: "ログインしてください。"
    end
  end
end
