class ChangeTitleIdOfUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :title_id, :integer, default: 1
  end

  def down
    change_column :users, :title_id, :integer
  end
end
