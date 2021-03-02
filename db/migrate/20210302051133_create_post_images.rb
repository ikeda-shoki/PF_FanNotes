class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.references :user, foreign_key: true
      t.string :image_id, null: false
      t.string :title, null: false
      t.text :image_introduction

      t.timestamps
    end
  end
end
