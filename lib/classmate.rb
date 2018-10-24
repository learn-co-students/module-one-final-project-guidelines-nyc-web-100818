class Classmate < Character

  attr_accessor :charms, :friends, :victories

  def initialize(attributes)
    super(attributes)
    @charms = []
    @friends = 0
    @victories = 0
  end

end
