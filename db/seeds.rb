require 'pry'
require 'rest-client'
require 'JSON'

def get_quotes_from_api
  quotes_string = RestClient.get('https://harrypotter.bloomsbury.com/scripts/quotes/quotes.json')
  JSON.parse(quotes_string)

end

# binding.pry

def get_quotes
  quotes = get_quotes_from_api
  quotes.each do |quote|
    # binding.pry
    seed_quote(quote)
  end
end

def seed_quote(quote)
  newquote = Quote.new
  newquote.dialog = quote["quote"]
  # binding.pry
end

get_quotes
