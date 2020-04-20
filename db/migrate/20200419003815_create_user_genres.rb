class CreateUserGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :user_genres do |t|
      t.integer :user_id
      t.integer :genre_id

      t.timestamps
    end
    add_index :user_genres, :user_id
    add_index :user_genres, :genre_id
    add_index :user_genres, [:user_id,:genre_id], unique: true
  end
end
