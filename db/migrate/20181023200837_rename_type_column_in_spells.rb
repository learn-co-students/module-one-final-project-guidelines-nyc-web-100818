class RenameTypeColumnInSpells < ActiveRecord::Migration[5.0]
  def change
    rename_column :spells, :type, :spell_type
  end
end
