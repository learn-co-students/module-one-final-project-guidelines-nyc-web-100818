# {
# "_id": "5b74ed2f3228320021ab622c",
# "spell": "Age Line",
# "type": "Enchantment",
# "effect": "Hides things from younger people",
# "__v": 0
# }
def create_spell_from_hash(spell_hash)
  type = spell_hash["type"]
  cp = ["Charm","Enchantment","Spell"].include?(type) ? rand(0..10) : 0
  hp = ["Hex","Curse","Jinx"].include?(type) ? rand(0..10) : 0
  Spell.create(name: spell_hash["spell"], description: spell_hash["effect"], spell_type: type, charm_points: cp, hit_points: hp)
end

def create_character_from_hash(character_hash)
  c_new = Character.new

  c_new.name = character_hash["name"]
  c_new.wand = character_hash["wand"]["core"]

  c_new.patronus = character_hash["patronus"] if character_hash["patronus"]
  # c_new.patronus = Faker::Creature::Animal.name

  c_new.gender = character_hash["gender"]
  c_new.birth_year = character_hash["dateOfBirth"]
  c_new.occupation = "student" if character_hash["hogwartsStudent"]
  c_new.occupation = "Hogwarts Employee" if character_hash["hogwartsStaff"]
  c_new.pet = ["cat", "owl", "toad", "rat"].sample
  c_new.hit_points = 1
  c_new.charm_points = 1
  c_new.save

  4.times do
    spell = Spell.all.sample
    c_new.spellbooks.create(character_id: c_new.id, spell_id: spell.id)
  end
end

def run_seed
  api = ApiCommunicator.new
  # get spells hash from API
  spells = api.get_spells
  spells.each do |spell|
    create_spell_from_hash(spell)
  end

  # get characters hash from API
  characters = api.get_characters
  characters.each do |character|
    create_character_from_hash(character)
  end
end

run_seed
