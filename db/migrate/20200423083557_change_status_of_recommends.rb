class ChangeStatusOfRecommends < ActiveRecord::Migration[6.0]
  def up
    change_column :recommends, :status, :integer, default: 1
  end

  def down
    change_column :recommends, :status, :integer
  end
end
