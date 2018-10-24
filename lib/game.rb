# main game class
class Game

  def initialize
    # create classmates array
    @classmates = []
    get_random_classmates
  end

  def get_random_classmates
    characters = Character.all.sample(9)
    characters.each do |character|
      classmate_hash = {
        name: character.name,
        gender: character.gender,
        house_id: character.house_id,
        wand: character.wand,
        patronus: character.patronus,
        pet: character.pet,
        charm_points: character.charm_points,
        hit_points: character.hit_points
      }
      classmate = Classmate.new(classmate_hash)
      classmate.spells = character.spells
      classmate.charms << Charm.all.sample(4)
      @classmates << classmate
    end
  end

  def player
    @player
  end

  def player=(player)
    @player = player
  end

  def classmates
    @classmates
  end

  def leaderboard
    # look at stats for player and students
    # return them to display
  end

end
