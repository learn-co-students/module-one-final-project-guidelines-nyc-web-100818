# UI - prompts, display messages, etc
class UI
  attr_accessor :game

  def display_welcome
    puts "Welcome to Hogwarts!"

    # 2. explain the game
    puts "This is a game where you befriend or defeat your fellow Hogwarts classmates."
  end

  def prompt_for_player_name
    print "Enter your name: "
    gets.chomp
  end

  def display_player_info(player)
    puts "#{player.name} is in house #{player.house.name}"
    puts "Your wand: #{player.wand}! Your pet: #{player.pet}! Your patronus: #{player.patronus}!"
  end

  def display_leaderboard
    puts self.game.lboard.all_scores
  end

  def display_classmate_info(classmate)
    puts "You meet #{classmate.name} in the hallway."
    puts "#{classmate.name} says hello! Some things you know about #{classmate.name}: Pet: #{classmate.pet}, Patonus: #{classmate.patronus}, House: #{classmate.house.name}"
  end

  # 5a. if win condition is met (user or AI player), go to end screen (10)
  def won?
    # checks player instance and student instances to see if anyone has gotten the points to win
    false
  end

  def turn
    display_leaderboard # display the leaderboard on each turn

    classmate = self.get_random_classmate # get a random classmate
    self.game.player.classmates_faced << classmate # keep track of who the student has met

    display_classmate_info(classmate) # show the classmate info

    valid_input = false
    until valid_input
      puts "Taunt or compliment? [T]/[C]"
      input = gets.chomp
      if input.upcase == "T"
        valid_input = true
        spell_combat(classmate)
      elsif input.upcase == "C"
        valid_input = true
        charm_combat(classmate)
      else
        puts "Invalid input!"
      end
    end
  end

  def get_random_classmate
    available_classmates = self.game.classmates.select{|classmate|
      self.game.player.classmates_faced.include?(classmate) == false
    }
    available_classmates.sample
  end

  def spell_combat(classmate)
    player_hit_points = self.game.player.hit_points
    classmate_hit_points = classmate.hit_points
    whose_turn = ["player","classmate"].sample # random player starts

    until player_hit_points <= 0 || classmate_hit_points <= 0
      puts "Your hit points: #{player_hit_points}"
      puts "#{classmate.name}'s hit points: #{classmate_hit_points}"
      if whose_turn == "player"
        player_spell = prompt_player_for_spell
        classmate_hit_points -= player_spell.hit_points
        puts "You cast #{player_spell.name}!"
        puts "#{classmate.name} takes #{player_spell.hit_points} damage."
        whose_turn = "classmate"
      else
        classmate_spell = classmate.spells.sample
        player_hit_points -= classmate_spell.hit_points
        puts "#{classmate.name} cast #{classmate_spell.name}!"
        puts "You take #{classmate_spell.hit_points} damage."
        whose_turn = "player"
      end
    end

    if player_hit_points <= 0
      puts "#{classmate.name} defeated you!"
      classmate.victories += 1
    else
      puts "You defeated #{classmate.name}!"
      self.game.player.victories += 1
    end

  end

  def prompt_player_for_spell
    spell_options = []
    self.game.player.spells.each_with_index{|spell, index|
      spell_options << "[#{index + 1}] #{spell.name}"
    }

    valid_input = false
    until valid_input
      puts "Pick a spell: "
      puts "#{spell_options.join("\n")}"
      spell_input = gets.chomp

      if spell_input.to_i.to_s == spell_input && spell_input.to_i.between?(1, self.game.player.spells.length)# check if number
        spell = self.game.player.spells[spell_input.to_i - 1]
        valid_input = true # exit loop
        return spell # return spell
      else
        puts "Invalid input!"
      end
    end
  end

  # a. if taunt is picked, go to combat screen (8)
  def charm_combat(classmate)
    player_charm_counter = 0
    opponent_charm_counter = 0
    until player_charm_counter == player.charm_points || opponent_charm_counter == opponent.charm_points
      # 8. Combat screen: show player's stats and opponent's stats and prompt user to pick a spell to cast
      puts "#{player.name} stats: #{player_start}"
      puts "#{opponent.name} stats: #{opponent_start}"
      # player.spells.map{||}
      puts "Pick a nice thing to say. 1) You smell lovely! 2) I like your shoes. 3) Your pet rat is SO fuzzy!"
      charm_input = gets.chomp

      # look up the charm
      charm = Charm.all.find_by(dialog: charm_input)

      if charm
        # a. Show effect of spell. If opponent's hit points reach 0, go to combat over screen (8c).
        opponent_charm_counter += charm.point
        puts "Explodo hit Ron! Ron's stats: HP: 1"
      else
        puts "invalid input"
      end

      # then AI player does a turn
      # b. Opponent casts spell. If player's charm points or hit points reach 0, go to combat over screen (8c). Otherwise, go to (8)
      opponent_charm = opponent.charms.sample
      player_charm_counter += opponent_charm.points
      puts "Ron cast Magic Missile! Your stats: HP: 7"
    end

    # c. Combat over screen: show combat result (who won, how many power/popularity points they get, how many power/popularity points the opponent gets)
    if player_charm_counter == player.charm_points
      puts "Ron smittened you!"
    else
      puts "You smittened ron!"
    end
    # update player stats and opponent stats

  end

  # 10. Game over screen: if win condition is met, show the outcome and some story text
  def display_game_over
    # todo
  end

  def run
    self.game = Game.new # start a new game

    display_welcome # call welcome method

    name_input = prompt_for_player_name # prompt for player to enter name

    player = Player.new(name_input) # create new player instance
    self.game.player = player

    self.game.initialize_leaderboard

    display_player_info(self.game.player) # display welcome message with player details

    until won?
      turn # take a turn
    end

    puts "You won! You're the most popular kid in school."

  end

end
