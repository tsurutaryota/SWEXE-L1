class TweetsController < ApplicationController
  before_action :require_login, only: [:new, :create, :destroy]

  def index
    @tweets = Tweet.includes(:user).order(created_at: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    if @tweet.save
      redirect_to root_path, notice: "投稿しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])

    if @tweet.user_id == current_user.id
      @tweet.destroy
      redirect_to root_path, notice: "投稿を削除しました。"
    else
      redirect_to root_path, alert: "自分の投稿のみ削除できます。"
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
