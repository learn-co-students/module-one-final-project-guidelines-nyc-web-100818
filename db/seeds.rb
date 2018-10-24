class SeedRunner
  include ModelMapper

  def run_seed
    api = ApiCommunicator.new

    # seed houses manually...
    puts "Seeding houses..."
    house_hashes = [{name: "Gryffindor",color: "Scarlet & Gold"},{name: "Slytherin",color: "Green & Silver"},{name: "Ravenclaw",color: "Blue & Bronze"},{name: "Hufflepuff",color: "Yellow & Black"}]
    house_hashes.each do |house_hash|
      House.create(house_hash)
    end

    # TODO: add more nice things
    puts "Seeding charms..."
    charm_hashes = [{dialog: "Something nice", points: 1}]
    charm_hashes.each do |charm_hash|
      Charm.create(charm_hash)
    end

    # get spells hash from API
    puts "Seeding spells..."
    spell_hashes = api.get_spells
    spell_hashes.each do |spell_hash|
      spell_args = map_to_spell(spell_hash) # map hash from API to our Spell class
      spell = Spell.new(spell_args)
      spell.save
    end

    # get characters hash from API
    puts "Seeding characters..."
    character_hashes = api.get_characters
    character_hashes.each do |character_hash|
      character_args = map_to_character(character_hash) # map hash from API to our Character class
      character = Character.new(character_args)
      character.save

      # Assign 4 random spells to character
      4.times do
        spell = Spell.all.sample
        spellbook = Spellbook.new(spell_id: spell.id)
        character.spellbooks << spellbook
      end

      # Assign character to a house based on house name
      house = House.find_by(name: character_hash["house"])
      if house
        house.characters << character
      end
    end

    # get quotes hash from API
    puts "Seeding quotes..."
    quote_hashes = api.get_quotes
    quote_hashes.each do |quote_hash|
      character = Character.find_by(name: quote_hash["character"])
      if character
        quote = Quote.new(dialog: quote_hash["quote"], character_id: character.id)
        character.quotes << quote
      end
    end

    puts "Seeding complete!"
  end

end

sr = SeedRunner.new
sr.run_seed
