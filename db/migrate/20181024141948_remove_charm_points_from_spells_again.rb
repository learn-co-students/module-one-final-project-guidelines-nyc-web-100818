class RemoveCharmPointsFromSpellsAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :spells, :charm_points
  end
end
