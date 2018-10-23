class ApiCommunicator
  # return a hash of spells
  # TODO: move API key to separate file...
  def get_spells
    response_string = RestClient.get("https://www.potterapi.com/v1/spells?key=$2a$10$eokIo6OAspmz.pVOZVouRekEERvDpUyM1bn2DxGVhKYNsIxasY7xW")
    JSON.parse(response_string)
  end

  def get_characters
    url = 'http://hp-api.herokuapp.com/api/characters'
    response = RestClient.get(url)
    JSON.parse(response)
  end
end

def get_quotes
  quotes_string = RestClient.get('https://harrypotter.bloomsbury.com/scripts/quotes/quotes.json')
  JSON.parse(quotes_string)
end
