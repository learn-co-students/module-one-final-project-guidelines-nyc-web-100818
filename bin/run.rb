require_relative '../config/environment'

greet_user
menu

api = API.new

selection = api.city_selection

hash = api.get_response(selection)

api.populate_db(hash)

current_city = api.selected_city(selection)

# binding.pry

today = today_weather(current_city)

api.city_today_info(current_city, today)

api.week_forecast(current_city)

menu2

# least_rain_forecast(current_city)

today_weather(current_city)

binding.pry

puts "END"
