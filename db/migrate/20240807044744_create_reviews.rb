class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :book, null: false, foreign_key: true
      t.text :review
      t.integer :score
      t.integer :up_votes

      t.timestamps
    end
  end
end
