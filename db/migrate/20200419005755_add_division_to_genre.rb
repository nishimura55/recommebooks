class AddDivisionToGenre < ActiveRecord::Migration[6.0]
  def change
    add_column :genres, :division, :string
  end
end
