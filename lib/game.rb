# main game class
class Game
  include SpellCombat

  attr_accessor :lboard, :player, :classmates

  def initialize
    # create classmates array
    @classmates = []
    get_random_classmates
  end

  def get_random_classmates
    characters = Classmate.all.select {|character| character.occupation == "student" || character.occupation == "staff" }.sample(9)
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

  def lost?
    self.classmates.any?{|classmate| classmate.victories == 10 || classmate.friends == 10}
  end

  def won?
    self.player.victories == 10 || self.player.friends == 10
  end

  def turn
    self.lboard.display_all # display the leaderboard on each turn

    classmate = self.get_random_classmate # get a random classmate

    classmate.display_intro # show the classmate info

    self.player.classmates_faced << classmate # keep track of who the student has met

    valid_input = false
    until valid_input
      puts "Taunt or compliment? [T]/[C]"
      input = gets.chomp
      if input.upcase == "T"
        valid_input = true
        spell_combat(self.player, classmate)
      elsif input.upcase == "C"
        valid_input = true
        charm_combat(classmate)
      else
        puts "Invalid input!"
      end
    end
  end

  def get_random_classmate
    available_classmates = self.classmates.select{|classmate|
      self.player.classmates_faced.include?(classmate) == false
    }
    available_classmates.sample
  end

end
