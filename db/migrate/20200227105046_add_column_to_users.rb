class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :favorite_genre, :string
  end
end
