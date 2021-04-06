class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # google以外の認証をする場合は %i[twitter, facebook]などとなります
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :post_images, dependent: :destroy
  has_many :post_image_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed_user, through: :followed, source: :follower
  has_many :request, class_name: "Request", foreign_key: "requester_id", dependent: :destroy
  has_many :requested, class_name: "Request", foreign_key: "requested_id", dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  attachment :profile_image

  validates :account_name, uniqueness: true
  validates :user_name, presence: true


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

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'many_post_images'
      return all.sort { |a, b| b.post_images.count <=> a.post_images.count}
    when 'many-requests'
      return all.sort { |a, b| b.complete_request_count <=> a.complete_request_count }
    end
  end

  def create_notification_follow(current_user, user)
    followed = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, user.id, 'follow'])
    if followed.blank?
      notification = current_user.active_notifications.new(
        visitor_id: current_user.id,
        visited_id: user.id,
        action: 'follow'
      )
     notification.save
    end
  end

  #google認証の為
  def self.find_or_create_for_oauth(auth)
    find_or_create_by!(email: auth.info.email) do |user|
      user.provider = auth.provider
      user.uid = auth.uid,
      user.user_name = auth.info.name,
      user.email = auth.info.email,
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
