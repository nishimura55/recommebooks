class RemoveIndexFromTitle < ActiveRecord::Migration[6.0]
  def change

    remove_index :titles, :name

  end
end
