class AddRakutenUrlToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :rakuten_url, :text
  end
end
