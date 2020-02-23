class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string, null: false
    add_column :users, :profile, :string
  end
end
