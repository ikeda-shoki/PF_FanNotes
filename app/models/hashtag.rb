class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum:99}
  has_many :post_image_hashtag_relations
  has_many :post_images, through: :post_image_hashtag_relations
end
