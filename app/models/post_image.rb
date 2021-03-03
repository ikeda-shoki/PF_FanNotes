class PostImage < ApplicationRecord
  
  belongs_to :user
  has_many :post_image_comments, dependent: :destroy
  
  attachment :image
  
  validates :title, presence: true
  validates :image, presence: true
end
