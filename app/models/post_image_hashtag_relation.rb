class PostImageHashtagRelation < ApplicationRecord
  belongs_to :post_image
  belongs_to :hashtag
end
