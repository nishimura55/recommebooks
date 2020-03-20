class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :story
      t.string :contributor_review
      t.integer :recomme_evaluation_point
      t.references :user, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
    add_index :books, [:user_id, :created_at]
  end
end
