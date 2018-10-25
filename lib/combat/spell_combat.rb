class SpellCombat
  attr_accessor :player, :classmate, :player_hp, :classmate_hp

  def initialize(player, classmate)
    @player = player
    @classmate = classmate
    @player_hp = player.hit_points
    @classmate_hp = classmate.hit_points
  end

  def display_stats
    puts "Your hit points: #{self.player_hp}"
    puts "#{self.classmate.name}'s hit points: #{self.classmate_hp}"
  end

  def display_results
    if @player_hp <= 0
      puts "#{self.classmate.name} defeated you!"
      self.classmate.victories += 1
    else
      puts "You defeated #{self.classmate.name}!"
      self.player.victories += 1
    end
  end

  def start
    whose_turn = ["player","classmate"].sample # random player starts

    until over?
      display_stats # show stats each turn
      if whose_turn == "player"
        puts "It's your turn."
        player_spell = prompt_player_for_spell
        self.classmate_hp -= player_spell.hit_points
        puts "You cast #{player_spell.name}!"
        puts "#{self.classmate.name} takes #{player_spell.hit_points} damage."
        whose_turn = "classmate"
      else
        puts "It's #{self.classmate.name}'s turn.'"
        sleep(3) # AI thinking...
        classmate_spell = self.classmate.spells.sample
        @player_hp -= classmate_spell.hit_points
        puts "#{self.classmate.name} cast #{classmate_spell.name}!"
        puts "#{classmate_spell.name} #{classmate_spell.description}."
        puts "You take #{classmate_spell.hit_points} damage."
        whose_turn = "player"
      end
    end

    display_results
  end

  def over?
    self.player_hp <= 0 || self.classmate_hp <= 0
  end

  def prompt_player_for_spell
    spell = nil
    until spell
      puts self.player.display_spell_options
      spell_input = gets.chomp
      if valid_spell_input?(spell_input)
        spell = self.player.spells[spell_input.to_i - 1]
      else
        puts "Invalid input!"
      end
    end
    spell
  end

  def valid_spell_input?(input_string)
    spell_number = input_string.to_i
    spell_number.to_s == input_string && spell_number.between?(1, self.player.spells.length) # check valid number
  end
end
