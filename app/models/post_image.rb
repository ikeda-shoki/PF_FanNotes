class PostImage < ApplicationRecord

  belongs_to :user
  has_many :post_image_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
      return find(Favorite.group(:post_image_id).order('count(post_image_id) desc').pluck(:post_image_id))
    when 'less_favorites'
      return find(Favorite.group(:post_image_id).order('count(post_image_id) asc').pluck(:post_image_id))
    end
  end
end
