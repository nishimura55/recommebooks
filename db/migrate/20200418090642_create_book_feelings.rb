class CreateBookFeelings < ActiveRecord::Migration[6.0]
  def change
    create_table :book_feelings do |t|
      t.integer :book_id
      t.integer :feeling_id

      t.timestamps
    end
    add_index :book_feelings, :book_id
    add_index :book_feelings, :feeling_id
    add_index :book_feelings, [:book_id,:feeling_id], unique: true
  end
end
