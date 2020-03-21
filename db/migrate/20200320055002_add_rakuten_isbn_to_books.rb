class AddRakutenIsbnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :rakuten_isbn, :string
  end
end
