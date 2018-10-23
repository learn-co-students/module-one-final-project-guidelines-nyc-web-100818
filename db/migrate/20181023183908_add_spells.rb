class AddSpells < ActiveRecord::Migration[5.0]
  def change
    create_table :spells do |t|
      t.string :name
      t.string :description
      t.integer :hit_points
      t.integer :charm_points

      t.timestamps
    end
  end
end
