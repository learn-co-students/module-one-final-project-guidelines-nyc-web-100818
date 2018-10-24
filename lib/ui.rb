# UI - prompts, display messages, etc
class UI

  def welcome
    # 1. welcome user
    puts "Welcome to Hogwarts!"

    # 2. explain the game
    puts "This is a game where you befriend or defeat your fellow Hogwarts classmates."
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
  end

  def turn
    until won?
      display_leaderboard
      # 6. show next action (random encounter - keep track of who student has already encountered)
      # pick a random student
      # 7. show story text and turn options (compliment, taunt)
      puts "You meet Ron in the hallway. "
      puts "Some info about Ron: his pet, patonus, house, etc."
      puts "Taunt or compiment? [t/c]"
      input = gets.chomp
      if input == "t"
        spell_combat
      elsif input == "c"
        charm_combat
      else
        puts "invalid input"
      end
    end
    puts "You won! You're the most popular kid in school."
  end

  # a. if taunt is picked, go to combat screen (8)
  def spell_combat
    until player.hit_points == 0 || opponent.hit_points == 0
      # 8. Combat screen: show player's stats and opponent's stats and prompt user to pick a spell to cast
      puts "Your stats: HP: 10"
      puts "Ron's stats: HP: 4"
      # player.spells.map{||}
      puts "Pick a spell. 1) Explodo; 2) Hocus Pocus; 3) Alakazam"
      spell_input = gets.chomp

      # look up the spell
      spell = Spell.all.find_by(name: spell_input)

      if spell
        # a. Show effect of spell. If opponent's hit points reach 0, go to combat over screen (8c).
        opponent.hit_points -= spell.hit_points
        puts "Explodo hit Ron! Ron's stats: HP: 1"
      else
        puts "invalid input"
      end

      # then AI player does a turn
      # b. Opponent casts spell. If player's charm points or hit points reach 0, go to combat over screen (8c). Otherwise, go to (8)

      opponent_spell = opponent.spells.sample
      player.hit_points -= opponent_spell.hit_points
      puts "Ron cast Magic Missile! Your stats: HP: 7"
    end


    # c. Combat over screen: show combat result (who won, how many power/popularity points they get, how many power/popularity points the opponent gets)
    if player.hit_points == 0
      puts "Ron defeated you!"
    else
      puts "You defeated ron!"
    end
    # update player stats and opponent stats

  end

  # a. if taunt is picked, go to combat screen (8)
  def charm_combat
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




end
