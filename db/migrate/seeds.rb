require 'pry'

def get_quotes_from_api
  quotes_string = RestClient.get('https://harrypotter.bloomsbury.com/scripts/quotes/quotes.json')
  quotes_hash = JSON.parse(quotes_string)
end

# binding.pry
def get_quotes
  quotes = get_quotes_from_api
end
