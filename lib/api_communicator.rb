require_all 'app'

class API

  attr_accessor :cities_hash

  def initialize
    @cities_hash ={
      "1" => 2459115, #new york
      "2" => 1591691, #cape_town
      "3" => 455825, #rio
      "4" => 1521894, #cairo
      "5" => 1062617, #singapore
      "6" => 753692 #barcelona
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
    response_string = RestClient.get("https://www.metaweather.com/api/location/#{@cities_hash[user_input]}/")
    response_hash = JSON.parse(response_string)
  end

  def populate_db(response_hash)
    City.find_or_create_by(name: response_hash["title"])

    response_hash["consolidated_weather"].each do |day|
      Weather.find_or_create_by(weather_type: day["weather_state_name"])
    end

    response_hash["consolidated_weather"].each do |day|
      cw = CityWeather.find_or_create_by(date: day["applicable_date"], daily_high: day["max_temp"] )
      cw.city_id = city.id
      cw.weather_id = weather.id
      # cw.daily_high = response_hash["consolidated_weather"][0]["max_temp"]
      # pulled from iterator# city_id: city.id, weather_id: weather.id
    end

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
