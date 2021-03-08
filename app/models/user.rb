class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :post_image_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed_user, through: :followed, source: :follower
  has_many :request, class_name: "Request", foreign_key: "requester_id", dependent: :destroy
  has_many :requested, class_name: "Request", foreign_key: "requested_id", dependent: :destroy

  attachment :profile_image

  validates :account_name, presence: true


  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  #フォローしているかの確認
  def following?(user)
    following_user.include?(user)
  end
end
