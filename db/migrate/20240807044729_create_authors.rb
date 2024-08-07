class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.date :date_of_birth
      t.string :country_of_origin
      t.text :description

      t.timestamps
    end
  end
end
