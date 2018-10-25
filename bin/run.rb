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

menu2 # ask if they want to choose another city, see data across cities, or exit

while true
  user_input = gets.chomp
  case user_input.to_i
    when 1 # go back to first menu
      menu
    when 2 # go to aggregate weather info page
      # we don't have this yet
      menu3
    when 3
      exit_weather_app # calling this method in cli.rb
  end
end


# least_rain_forecast(current_city)

today_weather(current_city)

binding.pry

puts "END"
