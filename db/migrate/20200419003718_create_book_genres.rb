class CreateBookGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :book_genres do |t|
      t.integer :book_id
      t.integer :genre_id

      t.timestamps
    end
    add_index :book_genres, :book_id
    add_index :book_genres, :genre_id
    add_index :book_genres, [:book_id,:genre_id], unique: true
  end
end
