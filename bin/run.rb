require_relative '../config/environment'

greet_user
menu

api = API.new

selection = api.city_selection

hash = api.get_response(selection)
# binding.pry

api.populate_db(hash)

current_city = api.selected_city(selection)

# binding.pry

api.city_today_info(current_city, hash)

api.week_forecast(current_city)

menu2

binding.pry

puts "END"
