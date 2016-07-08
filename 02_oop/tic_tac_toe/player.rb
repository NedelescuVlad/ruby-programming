class Player
  attr_reader :token
  attr_reader :name

  def initialize(name, token)
    @name = name
    @token = token
  end
end
