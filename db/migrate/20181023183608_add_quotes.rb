class AddQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.text :dialog
      t.integer :character_id
      t.timestamps
    end
  end
end
