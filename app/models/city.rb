require 'pry'

class City < ActiveRecord::Base
  has_many :city_weathers
  has_many :weathers, through: :city_weathers


  def my_weather #returns an array of all weather instances (from today up?)
    CityWeather.all.select do |date|
      date.city_id == self.id
    end
  end

  def average_high #returns integer in C of average high
    sum = 0
    counter = 0
    self.my_weather.each do |date|
      sum += date["daily_high"]
      counter += 1
    end
    return (sum/counter).to_i
  end

  def average_low #returns integer in C of average low
    sum = 0
    counter = 0
    self.my_weather.each do |date|
      sum += date["daily_low"]
      counter += 1
    end
    return (sum/counter).to_i
  end

  def temp_range
    max = self.my_weather.max do |date|
      date["daily_high"]
    end
    min = self.my_weather.min do |date|
      date["daily_low"]
    end

    hi_temp = max["daily_high"].to_i
    low_temp = min["daily_low"].to_i
    range = hi_temp - low_temp
    puts "
    Weekly high is #{hi_temp}
    Weekly low is #{low_temp}
    Weekly range is #{range}"
  end


end #class City
