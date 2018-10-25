class Weather < ActiveRecord::Base
  has_many :city_weathers
  has_many :cities, through: :city_weathers
end

#TODO add icons
