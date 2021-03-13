class RenamePhotoHashtagRelationsToPostImageHashtagRelations < ActiveRecord::Migration[5.2]
  def change
    rename_table :photo_hashtag_relations, :post_image_hashtag_relations
  end
end
