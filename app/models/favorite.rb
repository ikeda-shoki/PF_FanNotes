class Favorite < ApplicationRecord
  belongs_to :post_image
  belongs_to :user

  def self.favorite_post_image(user)
    where(user_id: user).pluck(:post_image_id)
  end

  scope :sort_favorite, -> (model_id) { order(Arel.sql("count(#{model_id}) desc")).pluck(model_id) }
end
