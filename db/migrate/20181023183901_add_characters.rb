class AddCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :gender
      t.integer :house_id
      t.string :wand
      t.string :patronus
      t.integer :birth_year
      t.string :occupation
      t.string :pet # cat, toad, owl, rat
      t.integer :hit_points
      t.integer :charm_points

      t.timestamps
    end
  end
end
