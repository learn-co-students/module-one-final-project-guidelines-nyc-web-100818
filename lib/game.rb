# main game class
class Game

  attr_accessor :lboard, :player, :classmates

  def initialize
    # create classmates array
    @classmates = []
    get_random_classmates
  end

  def get_random_classmates
    characters = Character.all.select {|character| character.occupation == "student" || character.occupation == "staff" }.sample(9)
    characters.each do |character|
      classmate_hash = {
        name: character.name,
        gender: character.gender,
        house_id: character.house_id,
        wand: character.wand,
        patronus: character.patronus,
        pet: character.pet,
        birth_year: character.birth_year,
        charm_points: character.charm_points,
        hit_points: character.hit_points,
        occupation: character.occupation
      }
      classmate = Classmate.new(classmate_hash)
      classmate.spells = character.spells
      classmate.charms << Charm.all.sample(4)
      @classmates << classmate
    end
  end # get_random_classmates

  def initialize_leaderboard
    @lboard = Leaderboard.new(self.player, self.classmates)
  end

end
