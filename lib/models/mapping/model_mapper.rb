module ModelMapper

  # returns a new hash from API mapped to arguments for Spell.new
  def map_to_spell(spell_hash)
    {
      name: spell_hash["spell"],
      description: spell_hash["effect"],
      spell_type: spell_hash["type"],
      hit_points: rand(1..10)
    }
  end

  # returns a new hash from API mapped to arguments for Character.new
  def map_to_character(character_hash)
    patronus = !character_hash["patronus"] || character_hash["patronus"] == "" ? MY_ANIMAL_FAKER.sample : character_hash["patronus"]
    if character_hash["hogwartsStudent"]
      occupation = "student"
    elsif character_hash["hogwartsStaff"]
      occupation = "staff"
    else
      occupation = "alumni"
    end

    pet = ["cat", "owl", "toad", "rat"].sample

    {
      name: character_hash["name"],
      wand: character_hash["wand"]["core"],
      patronus: patronus,
      gender: character_hash["gender"],
      birth_year: character_hash["yearOfBirth"],
      occupation: occupation,
      pet: pet,
      hit_points: 1,
      charm_points: 1
    }
  end
end
