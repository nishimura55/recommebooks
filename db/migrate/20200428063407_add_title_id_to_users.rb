class AddTitleIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :title_id, :integer
  end
end
