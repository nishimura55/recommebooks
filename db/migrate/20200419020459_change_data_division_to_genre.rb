class ChangeDataDivisionToGenre < ActiveRecord::Migration[6.0]
  def change
    change_column :genres, :division, :integer
  end
end
