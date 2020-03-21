class RemoveRakutenIsbnFromBooks < ActiveRecord::Migration[6.0]
  def change

    remove_column :books, :rakuten_isbn, :string
  end
end
