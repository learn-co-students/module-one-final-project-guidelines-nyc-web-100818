class Classmate < Character

  attr_accessor :charms

  def initialize(attributes)
    super(attributes)
    @charms = []
  end

end
