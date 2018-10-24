module SpellCombat

  def spell_combat(player, classmate)
    player_hit_points = player.hit_points
    classmate_hit_points = classmate.hit_points
    whose_turn = ["player","classmate"].sample # random player starts

    until player_hit_points <= 0 || classmate_hit_points <= 0
      puts "Your hit points: #{player_hit_points}"
      puts "#{classmate.name}'s hit points: #{classmate_hit_points}"
      if whose_turn == "player"
        player_spell = prompt_player_for_spell(player)
        classmate_hit_points -= player_spell.hit_points
        puts "You cast #{player_spell.name}!"
        puts "#{classmate.name} takes #{player_spell.hit_points} damage."
        whose_turn = "classmate"
      else
        classmate_spell = classmate.spells.sample
        player_hit_points -= classmate_spell.hit_points
        puts "#{classmate.name} cast #{classmate_spell.name}!"
        puts "#{classmate_spell.description}"
        puts "You take #{classmate_spell.hit_points} damage."
        whose_turn = "player"
        sleep(3)
      end
    end

    if player_hit_points <= 0
      puts "#{classmate.name} defeated you!"
      classmate.victories += 1
    else
      puts "You defeated #{classmate.name}!"
      player.victories += 1
    end

  end

  def prompt_player_for_spell(player)
    spell_options = []
    player.spells.each_with_index{|spell, index|
      spell_options << "[#{index + 1}] #{spell.name} - #{spell.description}"
    }

    valid_input = false
    until valid_input
      puts "Pick a spell: "
      puts "#{spell_options.join("\n")}"
      spell_input = gets.chomp

      if spell_input.to_i.to_s == spell_input && spell_input.to_i.between?(1, player.spells.length)# check if number
        spell = player.spells[spell_input.to_i - 1]
        return spell # return spell
      else
        puts "Invalid input!"
      end
    end
  end

end
