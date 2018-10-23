class RemoveCharmPointsFromCharacters < ActiveRecord::Migration[5.0]
  def change
    remove_column :characters, :charm_points
  end
end
