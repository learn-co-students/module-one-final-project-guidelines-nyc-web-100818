class RemoveCharmPointsFromSpells < ActiveRecord::Migration[5.0]
  def change
    remove_column :spells, :charm_points
  end
end
