class ChangeRecommePointDefaultOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :recomme_point, from: false, to: 0
  end
end
