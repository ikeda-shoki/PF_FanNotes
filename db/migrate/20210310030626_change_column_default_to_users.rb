class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :complete_request_count, from: nil, to: 0
  end
end
