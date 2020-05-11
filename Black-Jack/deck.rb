require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::VALUES.each do |value|
      Card::SUITS.each do |suit|
        score = value if [2, 3, 4, 5, 6, 7, 8, 9, 10].include?(value)
        score = 10 if %w[J Q K].include?(value)
        score = 11 if value == 'A'
        @cards << Card.new("#{value}#{suit}", score)
      end
    end
    @card_index = 0
    @deck_shuffled = @cards.shuffle!
  end

  def add_card(user)
    user.cards << @deck_shuffled[@card_index]
    user.score += @deck_shuffled[@card_index].score
    @card_index += 1
  end
end