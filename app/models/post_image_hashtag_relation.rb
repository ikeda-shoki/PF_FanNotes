class PostImageHashtagRelation < ApplicationRecord
  belongs_to :post_image
  belongs_to :hashtag
  
  scope :sort_favorite, -> (model_id, count) { order(Arel.sql("count(#{model_id}) desc")).limit(count) }
end
