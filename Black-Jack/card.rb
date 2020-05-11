class Card
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  SUITS = %w[+ <3 ^ <>].freeze

  attr_reader :name, :score

  def initialize(name, score)
    @name = name
    @score = score
  end
end