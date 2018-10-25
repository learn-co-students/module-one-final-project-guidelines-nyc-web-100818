# UI - prompts, display messages, etc
class UI
  attr_accessor :game

  def display_welcome
    puts "Welcome to Hogwarts!"
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

    until self.game.won? || self.game.lost?
      self.game.turn # take a turn
    end

    puts "You won! You're the most popular kid in school."

  end

end
