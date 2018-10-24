require 'rest-client'
require 'json'
require 'pry'

puts "api_communicator begins here"

response_string = RestClient.get('https://www.metaweather.com/api/location/search/?query=new')
response_hash = JSON.parse(response_string)

# binding.pry
puts "api_communicator has run"
