require_all 'app'

class API

  attr_accessor :cities_selector, :cities_names

  def initialize
    @cities_selector ={
      "1" => 2459115, #new york
      "2" => 1591691, #cape_town
      "3" => 455825, #rio
      "4" => 1521894, #cairo
      "5" => 1062617, #singapore
      "6" => 753692 #barcelona
    }
    @cities_names ={
      "1" => "New York",
      "2" => "Cape Town",
      "3" => "Rio de Janeiro",
      "4" => "Cairo",
      "5" => "Singapore",
      "6" => "Barcelona"
    }
  end

  def city_selection
    puts "Please enter a value from 1 - 6:"
    user_input = gets.chomp.to_i
      if user_input > 6 || user_input < 1
        puts "Please select a number from 1 to 6."
      else
        user_input.to_s
      end
  end

  #gets.chomp will only accept 1-6
  def get_response(user_input)
    response_string = RestClient.get("https://www.metaweather.com/api/location/#{@cities_selector[user_input]}/")
    response_hash = JSON.parse(response_string)
  end

  def populate_db(response_hash)
    city = City.find_or_create_by(name: response_hash["title"])

    response_hash["consolidated_weather"].each do |day|
      weather = Weather.find_or_create_by(weather_type: day["weather_state_name"])
      cw = CityWeather.find_or_create_by(date: day["applicable_date"], city_id: city.id)
      cw.daily_high = day["max_temp"]
      cw.daily_low = day["min_temp"]
      cw.sun_rise = response_hash["sun_rise"]
      cw.sun_set = response_hash["sun_set"]
      cw.weather_id = weather.id
      cw.save
    end
  end

  def selected_city(selection)
    city = @cities_names[selection]
    City.find_by(name: city)
  end

  def city_today_info(current_city, today)
    puts "Today's Forecast for #{current_city.name}:\n\n"

    puts "#{today.weather["weather_type"]}"
    # binding.pry
    puts "High - #{celsius_fahrenheit(today["daily_high"])} ºF"
    puts "Low - #{celsius_fahrenheit(today["daily_low"])} ºF"
    sr1 = today["sun_rise"].split(/[T.]/)[1]
    sr2 = sr1.split(":")
    sr3 = "#{sr2[0]}:#{sr2[1]}"
    ss1 = today["sun_set"].split(/[T.]/)[1]
    ss2 = ss1.split(":", -1)
    ss3 = "#{ss2[0].to_i - 12}:#{ss2[1]}" #fix leading zero missing
    puts "Sunrise - #{sr3} AM"
    puts "Sunset - #{ss3} PM"
    #put weather state here somehwere
  end

  def week_forecast(current_city)
    puts "#{current_city.name} weekly forecast:\n\n"
    puts "Weekly average high is #{celsius_fahrenheit(current_city.average_high)} ºF\n"
    puts "Weekly average low is #{celsius_fahrenheit(current_city.average_low)} ºF\n"
    current_city.temp_range

    #put weather state icon for each day
  end

  def celsius_fahrenheit(c)
    f = ( c * 9 / 5) + 32
    f.to_i
  end

end #class API


# response_string = RestClient.get('https://www.metaweather.com/api/location/search/?query=new')
# response_hash = JSON.parse(response_string)
#USE THIS FOR QUERY OPTION LATER




=begin
####NEW YORK WEATHER

#CITY NAME
response_hash["title"]

#TODAYS DATE FROM HASH
hash_date = response_hash["consolidated_weather"][0]["applicable_date"]


#TODAYS WEATHER
response_hash["consolidated_weather"][0]

max_temp = response_hash["consolidated_weather"][0]["max_temp"]
min_temp = response_hash["consolidated_weather"][0]["min_temp"]
weather_state = response_hash["consolidated_weather"][0]["weather_state_name"]

todays_sun_rise = response_hash["sun_rise"].split(/[T.]/)[1] + " AM"
todays_sun_set = response_hash["sun_set"].split(/[T.]/)[1] + " PM" #fix mil time

#TOMORROWS WEATHER
response_hash["consolidated_weather"][1]

#CITY GOOGLE MAPS
latt_long = response_hash["latt_long"] #send straight to google maps (https://www.google.com/maps/place/[INSERT LATT LONG HERE])

testcity = City.new

City.find_or_create_by(name: "New York")
CityWeather.find_or_create_by(date: hash_date)
=end

# binding.pry
