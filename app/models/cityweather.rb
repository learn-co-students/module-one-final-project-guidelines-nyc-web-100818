class CityWeather < ActiveRecord::Base
  belongs_to :city
  belongs_to :weather
end
