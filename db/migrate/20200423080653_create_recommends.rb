class CreateRecommends < ActiveRecord::Migration[6.0]
  def change
    create_table :recommends do |t|
      t.integer :recommender_id
      t.integer :recommended_id
      t.integer :book_id
      t.string :body
      t.integer :status

      t.timestamps
    end
  end
end
