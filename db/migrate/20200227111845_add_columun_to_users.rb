class AddColumunToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :recomme_point, :integer, null: false
  end
end
