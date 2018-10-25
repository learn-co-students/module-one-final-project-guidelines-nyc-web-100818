class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
     create_table :weathers do |t|
       t.string :weather_type #consolidated_weather => weather_state_name in hash
     end
   end
end
