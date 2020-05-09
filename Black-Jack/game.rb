%w[user dealer].each { |f| require_relative f }

class Game
  attr_reader :user, :dealer, :card_index, :round_bank

  REGULAR_BANK = 10

  def initialize
    @card_index = 0
    @round_bank = 0
  end

  def start_game
    print 'Введите имя игрока:'
    name = gets.chomp
    @user = User.new(name)
    @dealer = Dealer.new('Dealer')

    loop do
      new_game
      @user.make_game
      @dealer.make_game
    end
  end

  def new_game
    @user.cards = []
    @dealer.cards = []
    @user.score = 0
    @dealer.score = 0
    @round_bank = 0
    @card_index = 0

    @user.set_cards
    @user.total_score
    @user.put_bank(REGULAR_BANK)
    @dealer.set_cards
    @dealer.put_bank(REGULAR_BANK)
    @round_bank += REGULAR_BANK * 2
  end
end
