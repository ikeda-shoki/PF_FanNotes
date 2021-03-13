class PostImage < ApplicationRecord

  belongs_to :user
  has_many :post_image_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_image_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :post_image_hashtag_relations

  attachment :image

  validates :title, presence: true
  validates :image, presence: true

  def favorited_by?(user)
    self.favorites.where(user_id: user.id).exists?
  end

  #検索時の並び替え選択に使用
  def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'many_favorites'
      return all.sort { |a, b| b.favorites.count <=> a.favorites.count}
    when 'less_favorites'
      return all.sort { |a, b| b.favorites.count <=> a.favorites.count}.reverse
    end
  end

  after_create do
    post_image = PostImage.find_by(id: self.id)
    post_image_hashtags = self.image_introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post_image.hashtags = []
    post_image_hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#＃'))
      post_image.hashtags << tag
    end
  end

  before_update do
    post_image = PostImage.find_by(id: self.id)
    post_image.hashtags.clear
    post_image_hashtags = self.image_introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post_image_hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#＃'))
      post_image.hashtags << tag
    end
  end
end
