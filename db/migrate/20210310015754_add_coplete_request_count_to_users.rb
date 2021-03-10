class AddCopleteRequestCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :complete_request_count, :integer
  end
end
