class Weather < ActiveRecord::Base
  has_many :dates
  has_many :cities, through: :dates
end

#TODO add icons
