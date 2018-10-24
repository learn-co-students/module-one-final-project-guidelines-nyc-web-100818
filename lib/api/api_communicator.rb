class ApiCommunicator

  def get_spells
    response_string = RestClient.get("https://www.potterapi.com/v1/spells?key=$2a$10$eokIo6OAspmz.pVOZVouRekEERvDpUyM1bn2DxGVhKYNsIxasY7xW")
    JSON.parse(response_string)
  end

  # returns a new hash from API mapped to arguments for Spell.new
  def map_hash_to_spell(spell_hash)
    charm_points = ["Charm","Enchantment","Spell"].include?(spell_hash["type"]) ? rand(0..10) : 0
    hit_points = ["Hex","Curse","Jinx"].include?(spell_hash["type"]) ? rand(0..10) : 0
    {
      name: spell_hash["spell"],
      description: spell_hash["effect"],
      spell_type: spell_hash["type"],
      charm_points: charm_points,
      hit_points: hit_points
    }
  end

  def get_characters
    url = 'http://hp-api.herokuapp.com/api/characters'
    response = RestClient.get(url)
    JSON.parse(response)
  end

  def get_quotes
    quotes_string = RestClient.get('https://harrypotter.bloomsbury.com/scripts/quotes/quotes.json')
    JSON.parse(quotes_string)
  end

end
