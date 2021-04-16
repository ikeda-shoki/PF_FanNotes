class PostImage < ApplicationRecord
  belongs_to :user
  has_many :post_image_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_image_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :post_image_hashtag_relations
  has_many :notifications, dependent: :destroy

  attachment :image

  enum post_image_genre: { イラスト: 0, 写真: 1, ロゴ: 2 }

  validates :title, presence: true
  validates :image, presence: true
  validates :post_image_genre, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索時の並び替え選択に使用
  def self.sort(selection)
    case selection
    when 'new'
      preload(:user).all.order(created_at: :DESC)
    when 'old'
      preload(:user).all.order(created_at: :ASC)
    when 'many_favorites'
      # いいね数が0を含めた投稿も表示させる
      preload(:user).all.sort { |a, b| b.favorites.count <=> a.favorites.count }
    when 'less_favorites'
      preload(:user).all.sort { |a, b| b.favorites.count <=> a.favorites.count }.reverse
    end
  end

  after_create do
    post_image = PostImage.find_by(id: id)
    post_image_hashtags = image_introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post_image.hashtags = []
    post_image_hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#＃'))
      post_image.hashtags << tag
    end
  end

  before_update do
    post_image = PostImage.find_by(id: id)
    post_image.hashtags.clear
    post_image_hashtags = image_introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post_image_hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#＃'))
      post_image.hashtags << tag
    end
  end

  def create_notification_favorite(current_user)
    favorited = Notification.where(["visitor_id = ? and visited_id = ? and post_image_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    if favorited.blank?
      notification = current_user.active_notifications.new(
        post_image_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      unless notification.visitor_id === notification.visited_id
        notification.save
      end
    end
  end

  def create_notification_post_image_comment(current_user)
    notification = current_user.active_notifications.new(
      post_image_id: id,
      visited_id: user_id,
      action: 'post_image_comment'
    )
    unless notification.visitor_id === notification.visited_id
      notification.save
    end
  end

  # controller用
  def get_post_image_comment
    post_image_comments.preload(:user).order('created_at DESC')
  end
  
  # controller用 scope
  scope :sort_new, -> (count) { order('id desc').limit(count) }
  scope :my_follower_img, -> (current_user) { where(user_id: current_user.following_user.pluck(:id)) }
  
end
