class CreatePhotoHashtagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_hashtag_relations do |t|
      t.references :post_image, foreign_key: true
      t.references :hashtag, foreign_key: true

      t.timestamps
    end
  end
end
