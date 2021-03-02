class CreateRequestImages < ActiveRecord::Migration[5.2]
  def change
    create_table :request_images do |t|
      t.references :request, foreign_key: true
      t.string :complete_image_id, null: false

      t.timestamps
    end
  end
end
