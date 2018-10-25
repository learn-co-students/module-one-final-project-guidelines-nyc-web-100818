require_relative '../config/environment'
require 'pry'

def day_length
  sun_rise = "2018-10-24T06:12:59.885084-02:00"
  sun_set = "2018-10-24T19:29:15.416047-02:00"
  sr1 = sun_rise.split(/[T.]/)[1]
  ss1 = sun_set.split(/[T.]/)[1]
  sr2 = sr1.split(":")
  ss2 = ss1.split(":")
  hour = ss2[0].to_i - sr2[0].to_i
  min = (60 - sr2[1].to_i) + (ss2[1].to_i)
  if min > 60
    hour += 1
    min -= 60
  end
  puts "Day length today is #{hour} hours and #{min} minutes."
end

def least_rain_forecast(current_city)
  puts "#{current_city.name}"

  current_city.city_weathers.each do
  end
end

def city_weather_today_and_forecast #returns CityWeather for today and future dates
  CityWeather.all.select do |cw|
    now = DateTime.now
    now2 = now.change(hour: 0, offset: 0)
    split = cw["date"].split("-")
    converted_time1 = DateTime.new
    converted_time2 = converted_time1.change(year: split[0].to_i, month: split[1].to_i, day: split[2].to_i)
    converted_time2 >= now2
  end
end

def hottest_day #will find hottest day instance in the next 6 days
  city_weather_today_and_forecast.max_by do |cw|
    cw["daily_high"]
  end
end

#hottest_day.city["name"] will return city name with hottest day

def coolest_day
  city_weather_today_and_forecast.min_by do |cw|
    cw["daily_high"]
  end
end

#coolest_day.city["name"] will return city name with coolest day

def longest_day_length
end

def today_weather(current_city) #returns CityWeather instance for passed in city
  now = DateTime.now
  current_city.city_weathers.find do |cw|
    cw["date"] == "#{now.year}-#{now.month}-#{now.day}"
  end
end

def dt_conversion(string)
  split = string.split("-")
  converted_time1 = DateTime.new
  converted_time2 = converted_time1.change(year: split[0].to_i, month: split[1].to_i, day: split[2].to_i)
  converted_time2
end
