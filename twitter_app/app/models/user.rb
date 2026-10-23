class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
  validates :pass, presence: true

  def like(tweet)
    likes.find_or_create_by(tweet: tweet)
  end

  def unlike(tweet)
    likes.find_by(tweet: tweet)&.destroy
  end

  def liked?(tweet)
    likes.exists?(tweet: tweet)
  end
end
