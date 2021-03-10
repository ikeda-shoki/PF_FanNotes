class PostImage < ApplicationRecord

  belongs_to :user
  has_many :post_image_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: "favorites", source: :post_image

  attachment :image

  validates :title, presence: true
  validates :image, presence: true

  def favorited_by?(user)
    self.favorites.where(user_id: user.id).exists?
  end

  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'many_favorites'
      return all.sort { |a, b| b.favorited_posts.count <=> a.favorited_posts.count}
    when 'less_favorites'
      return all.sort { |a, b| b.favorited_posts.count <=> a.favorited_posts.count}.reverse
    end
  end
end
