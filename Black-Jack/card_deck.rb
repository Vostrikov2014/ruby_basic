class CardDeck
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  SUITS = ['+', '<3', '^', '<>']

  attr_reader :cards

  def initialize
    @cards = {}
    VALUES.each do |value|
      SUITS.each do |suit|
        score = value if [2, 3, 4, 5, 6, 7, 8, 9, 10].include?(value)
        score = 10 if %w[J Q K].include?(value)
        score = 11 if value == 'A'
        @cards["#{value}#{suit}"] = score
      end
    end
  end

  def shuffled_card
    @cards.keys.shuffle!
  end

  def card_value(value)
    @cards[value]
  end
end