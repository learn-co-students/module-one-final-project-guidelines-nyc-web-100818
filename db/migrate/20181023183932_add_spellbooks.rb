class AddSpellbooks < ActiveRecord::Migration[5.0]
  def change
    create_table :spellbooks do |t|
      t.integer :character_id
      t.integer :spell_id

      t.timestamps
    end
  end
end
