require_relative 'user'
require_relative 'deck'

class Game
  attr_reader :user, :dealer, :deck, :bank_game

  REGULAR_BANK = 10

  def initialize(name)
    @user = User.new(name)
    @dealer = User.new('Dealer')
  end

  def new_game
    @bank_game = 0
    @bank_game += REGULAR_BANK * 2

    @deck = Deck.new

    @user.cards = []
    @user.score = 0
    2.times { @deck.add_card(@user) }
    @user.put_bank(REGULAR_BANK)

    @dealer.cards = []
    @dealer.score = 0
    2.times { @deck.add_card(@dealer) }
    @dealer.put_bank(REGULAR_BANK)
  end

  def dealer_make_game
    @deck.add_card(@dealer) if @dealer.score < 17
  end
end
