# UI - prompts, display messages, etc
class UI
  attr_accessor :game

  def welcome
    # 1. welcome user
    puts "Welcome to Hogwarts!"

    # 2. explain the game
    puts "This is a game where you befriend or defeat your fellow Hogwarts students."
  end

  def get_player_name
    # 3. get user name
    print "Enter your name: "
    gets.chomp
  end

  def welcome_player(player)

    puts "#{player.name} is in house #{player.house.name}"
    puts "Your wand: #{player.wand}! Your pet: #{player.pet}! Your patronus: #{player.patronus}!"
  end

  def display_leaderboard
    # 5. show leaderboard (# students defeated/# students befriended)
    puts "The current leaderboard: "
    # get leaderboard from Game instance
    puts "You: Students defeated: 0, Students befriended: 0"
    puts "Ron: Students defeated: 0, Students befriended: 0"
  end

  # 5a. if win condition is met (user or AI player), go to end screen (10)
  def won?
    # checks player instance and student instances to see if anyone has gotten the points to win
    false
  end

  def turn
    display_leaderboard
    # 6. show next action (random encounter)
    opponent = self.game.classmates.sample
    # TODO: keep track of who student has already encountered
    # pick a random student
    # 7. show story text and turn options (compliment, taunt)
    puts "You meet #{opponent.name} in the hallway. "
    puts "Some info about #{opponent.name}: pet: #{opponent.pet}, patonus: #{opponent.patronus}, house: #{opponent.house}"
    valid_input = false
    until valid_input
      print "Taunt or compiment? [t/c]"
      input = gets.chomp
      if input == "t"
        valid_input = true
        self.spell_combat(opponent)
      elsif input == "c"
        valid_input = true
        self.charm_combat(opponent)
      else
        puts "invalid input"
      end
    end
  end

  # a. if taunt is picked, go to combat screen (8)
  def spell_combat(opponent)
    player_hit_points = self.game.player.hit_points
    opponent_hit_points = opponent.hit_points
    whose_turn = ["player","opponent"].sample # random player starts

    until player_hit_points <= 0 || opponent_hit_points <= 0

      puts "Your hit points: #{player_hit_points}"
      puts "#{opponent.name}'s hit points: #{opponent_hit_points}"

      if whose_turn == "player"
        player_spell = prompt_player_for_spell
        binding.pry
        opponent_hit_points -= player_spell.hit_points
        puts "You cast #{player_spell.name}! #{opponent.name} takes #{player_spell.hit_points} damage."
        whose_turn = "opponent"
      else
        opponent_spell = opponent.spells.sample
        player_hit_points -= opponent_spell.hit_points
        puts "#{opponent.name} cast #{opponent_spell.name}!"
        whose_turn = "player"
      end

    end
    # c. Combat over screen: show combat result (who won, how many power/popularity points they get, how many power/popularity points the opponent gets)
    if self.game.player.hit_points == 0
      puts "#{opponent.name} defeated you!"
    else
      puts "You defeated #{opponent.name}!"
    end
    # update player stats and opponent stats
    # self.player.points += 1
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
      if spell_input.to_i.to_s == spell_input # check if number
        spell = self.game.player.spells[spell_input.to_i - 1]
        if spell
          valid_input = true # exit loop
          return spell # return spell
        else
          puts "Invalid input!"
        end
      else
        puts "Invalid input!"
      end
    end
  end

  # a. if taunt is picked, go to combat screen (8)
  def charm_combat(opponent)
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


  def run
    self.game = Game.new # start a new game

    welcome # call welcome method

    name_input = get_player_name # prompt for player to enter name

    player = Player.new(name_input) # create new player instance
    self.game.player = player

    welcome_player(self.game.player) # display welcome message with player details

    until won?
      turn # take a turn
    end

    puts "You won! You're the most popular kid in school."

  end

end
