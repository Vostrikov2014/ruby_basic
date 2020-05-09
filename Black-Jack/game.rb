%w[user card_deck].each { |f| require_relative f }

class Game
  attr_reader :user, :dealer, :card_index, :round_bank

  REGULAR_BANK = 10

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new('Dealer')
    @card_index = 0
    @round_bank = 0
  end

  def start_game
    loop do
      new_game
      user_make_game(@user)
      dealer_make_game(@dealer)
    end
  end

  def new_game
    @card_deck = CardDeck.new
    @card_deck_shuffled = @card_deck.shuffled_card
    @user.cards = []
    @dealer.cards = []
    @user.score = 0
    @dealer.score = 0
    @round_bank = 0
    @card_index = 0

    @user.cards << @card_deck[@card_index, @card_index += 1]
    @user.put_bank(REGULAR_BANK)
    puts @user.cards

    @dealer.cards << @card_deck[@card_index += 1, @card_index += 1]
    @dealer.put_bank(REGULAR_BANK)

    @round_bank += REGULAR_BANK * 2
  end

  def user_make_game(user)
    puts "Карты: #{@user.cards}"
    puts "Очки: #{@user.score}"
    puts ' Введите: 1 - пропустить ход, 2 - добавить карту, 3 - открыть карты'
    entered_number = gets.chomp.to_i

    return if entered_number == 1
    add_card(user) if entered_number == 2
    open_cards if entered_number == 3
  end

  def dealer_make_game(user)


  end

  def add_card(user)
    user.cards << @card_deck_shuffled[@card_index]
    user.score += @card_deck.card_value(@card_deck_shuffled[@card_index])
    @card_index += 1
  end
end
