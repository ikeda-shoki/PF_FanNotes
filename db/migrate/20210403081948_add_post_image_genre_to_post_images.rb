class AddPostImageGenreToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_column :post_images, :post_image_genre, :integer, default: 0, null: false
  end
end
