class Player < Character

  attr_accessor :charms, :spells, :friends, :victories, :classmates_faced

  # TODO: update to save character to database... find/create by name
  def initialize(name)
    super(name: name)
    self.hit_points = 10
    self.charm_points = 10
    self.name = name
    self.house_id = House.all.sample.id
    self.wand = Character.all.sample.wand
    self.pet = ["cat", "owl", "toad", "rat"].sample
    self.patronus = MY_ANIMAL_FAKER.sample
    @spells = Spell.all.sample(4)
    @charms = Charm.all.sample(4)
    @classmates_faced = []
    self.friends = 0
    self.victories = 0
  end

end
