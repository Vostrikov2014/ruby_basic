%w[card].each { |f| require_relative f }

class Users
  attr_accessor :cards, :score
  attr_reader :name, :bank

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

  def set_cards
    @cards << Card.new.shuffled_card[0, 1]
  end

  def total_score

  end

  def add_card
    @cards << Card.new.shuffled_card[0]
  end

  def open_cards

  end

end