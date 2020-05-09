class User
  attr_accessor :cards, :score
  attr_reader :name

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @score = 0
  end

  def put_bank(value)
    @bank -= value
  end

  def get_win(value)
    @bank += value
  end
end