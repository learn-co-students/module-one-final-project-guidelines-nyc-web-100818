class Player < Character

  def initialize(name)
    super(name: name)
    self.name = name
    self.house_id = House.all.sample.id
    # wand, pet, patronus,
    # spells, charms
  end

end
