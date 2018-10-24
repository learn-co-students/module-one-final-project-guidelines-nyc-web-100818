class Player < Character

  attr_accessor :charms

  def initialize(name)
    super(name: name)
    @charms = []
    self.name = name
    self.house_id = House.all.sample.id
    self.wand = Character.all.sample.wand
    self.pet = ["cat", "owl", "toad", "rat"].sample
    self.patronus = MY_ANIMAL_FAKER.sample
    4.times do
      spell = Spell.all.sample
      spellbook = Spellbook.new(spell_id: spell.id)
      self.spellbooks << spellbook
    end
    self.charms << Charm.all.sample(4)
  end

end
