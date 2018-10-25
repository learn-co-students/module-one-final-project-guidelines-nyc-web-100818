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

  def display_game_over
    if self.game.won?
      puts "You won!"
    else
      puts "You lost :("
    end
  end

  def run
    self.game = Game.new # start a new game

    display_welcome # display welcome message

    name_input = prompt_for_player_name # prompt for player to enter name

    player = Player.new(name_input) # create new player instance
    self.game.player = player

    self.game.initialize_leaderboard # player must be initialized before leaderboard can be initialized

    display_player_info(self.game.player) # display welcome message with player details

    until self.game.over?
      self.game.turn # take a turn
    end

    display_game_over

  end

end
