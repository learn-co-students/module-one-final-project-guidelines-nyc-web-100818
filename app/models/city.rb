class City < ActiveRecord::Base
  has_many :dates
  has_many :weathers, through: :dates
end
