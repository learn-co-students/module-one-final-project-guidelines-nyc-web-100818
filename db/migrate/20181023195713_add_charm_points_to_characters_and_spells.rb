class AddCharmPointsToCharactersAndSpells < ActiveRecord::Migration[5.0]
  def change
    add_column :spells, :charm_points, :integer
    add_column :characters, :charm_points, :integer
  end
end
