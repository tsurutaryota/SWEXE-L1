class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
  validates :pass, presence: true
end
