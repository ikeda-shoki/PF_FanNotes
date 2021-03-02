class CreatePostImageComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_image_comments do |t|
      t.references :user, foreign_key: true
      t.references :post_image, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end
  end
end
