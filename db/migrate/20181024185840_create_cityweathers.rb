class CreateCityweathers < ActiveRecord::Migration[5.0]
  def change
    create_table :city_weathers do |t|
      t.string :date #date formats? consolidated_weather => applicable_date
      t.float :daily_high #max_temp
      t.float :daily_low #min_temp
      t.string :sun_rise #sun_rise
      t.string :sun_set #sun_set
      t.integer :weather_id
      t.integer :city_id
    end
  end
end
