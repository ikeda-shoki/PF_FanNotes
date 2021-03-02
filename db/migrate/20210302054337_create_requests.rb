class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :requester, foreign_key: { to_table: :users }
      t.references :requested, foreign_key: { to_table: :users }
      t.text :request_introduction, null: false
      t.string :reference_image_id
      t.integer :file_format, null: false, default: 0
      t.text :use, null: false
      t.string :deadline, null: false
      t.integer :amount, null: false, default: 1
      t.integer :request_status, null: false, default: 0

      t.timestamps
    end
  end
end
