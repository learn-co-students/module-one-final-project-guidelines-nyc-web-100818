require_relative '../config/environment'

greet_user
menu

api = API.new

selection = api.city_selection

hash = api.get_response(selection)
# binding.pry

api.populate_db(hash)

binding.pry

puts "END"
