class CreateFeelings < ActiveRecord::Migration[6.0]
  def change
    create_table :feelings do |t|
      t.string :situation

      t.timestamps
    end
    add_index :feelings, :situation, unique:true
  end
end
