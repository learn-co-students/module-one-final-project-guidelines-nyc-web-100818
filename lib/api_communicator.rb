puts "api_communicator begins here"

# response_string = RestClient.get('https://www.metaweather.com/api/location/search/?query=new')
# response_hash = JSON.parse(response_string)

# https://www.metaweather.com/api/location/2459115/ (New York)

response_string_ny = RestClient.get('https://www.metaweather.com/api/location/2459115/')
response_hash_ny = JSON.parse(response_string_ny)

# def test_hash
#   response_hash
# end

#why is run not able to see response_hash variable?

####NEW YORK WEATHER

#TODAYS WEATHER
response_hash_ny["consolidated_weather"][0]
max_temp = response_hash_ny["consolidated_weather"][0]["max_temp"]
min_temp = response_hash_ny["consolidated_weather"][0]["min_temp"]
weather_state = response_hash_ny["consolidated_weather"][0]["weather_state_name"]

todays_sun_rise = response_hash_ny["sun_rise"].split(/[T.]/)[1] + " AM"
todays_sun_set = response_hash_ny["sun_set"].split(/[T.]/)[1] + " PM" #fix mil time

latt_long = response_hash_ny["latt_long"] #send straight to google maps (https://www.google.com/maps/place/[INSERT LATT LONG HERE])




#TOMORROWS WEATHER
response_hash_ny["consolidated_weather"][1]



binding.pry
puts "api_communicator has run"
