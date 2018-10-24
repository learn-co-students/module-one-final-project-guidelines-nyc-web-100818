class Leaderboard

  attr_reader :contenders

  def initialize(player, classmates)
    @contenders = (classmates.unshift(player))
  end

  # gets the victories and friends of a character
  def score(contender)
    self.contenders.include?(contender) ? "#{contender.name} |\n #{contender.friends} friends on WitchBook | #{contender.victories} notches on their wand" : "This contender doesn't seem to exist"
  end

  def all_scores
    scores = "|||Leaderboard|||\n"
    self.contenders.each { |contender| scores = scores + "#{score(contender)}" + "\n" }
    scores
  end

end
