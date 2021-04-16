class Favorite < ApplicationRecord
  belongs_to :post_image
  belongs_to :user
  
  scope :sort_favorite, -> (model_id) { order(Arel.sql("count(#{model_id}) desc")).pluck(model_id) }
end
