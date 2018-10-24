class AddCharmsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :charms do |t|
      t.string :dialog
      t.integer :points
    end
  end
end
