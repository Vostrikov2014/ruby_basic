%w[user card_deck].each { |f| require_relative f }

class Game
  attr_reader :user, :dealer, :card_index, :round_bank

  REGULAR_BANK = 10

  def initialize(name)
    @user = User.new(name)
    @dealer = Dealer.new('Dealer')
    @card_index = 0
    @bank_game = 0
  end

  def start_game
    loop do
      new_game
      user_make_game
      dealer_make_game

      puts 'Введите: 1 - продолжить, 2 - выход'
      entered_number = gets.chomp.to_i
      next if entered_number == 1
      break  if entered_number == 2
    end
  end

  def new_game
    @card_index = 0
    @card_deck = CardDeck.new
    @card_deck_shuffled = @card_deck.shuffled_card

    @bank_game = 0
    @bank_game += REGULAR_BANK * 2

    @user.cards = []
    @user.score = 0
    (1..2).each { |n| add_card(@user)}
    @user.put_bank(REGULAR_BANK)
    puts @user.cards

    @dealer.cards = []
    @dealer.score = 0
    (1..2).each { |n| add_card(@dealer)}
    @dealer.put_bank(REGULAR_BANK)
  end

  def user_make_game
    puts "Карты: #{@user.cards}"
    puts "Очки: #{@user.score}"
    puts ' Введите: 1 - пропустить ход, 2 - добавить карту, 3 - открыть карты'
    entered_number = gets.chomp.to_i

    return if entered_number == 1
    add_card(@user) if entered_number == 2
    open_cards if entered_number == 3
  end

  def dealer_make_game
    add_card(@dealer) if @dealer.score < 17
  end

  def add_card(user)
    user.cards << @card_deck_shuffled[@card_index]
    user.score += @card_deck.card_value(@card_deck_shuffled[@card_index])
    @card_index += 1
  end

  def open_cards
    if @user.score > @dealer.score && @user.score <= 21 || @dealer.score > 21 && user.score <= 21
      @user.get_win(@bank_game)
      puts "Победил #{@user.name}!"
    elsif @dealer.score > @user.score && @dealer.score <= 21 || @dealer.score <= 21 && user.score > 21
      @dealer.get_win(@bank_game)
      puts "Победил #{@user.name}!"
    else
      @user.get_win(@bank_game / 2)
      @dealer.get_win(@bank_game / 2)
      puts 'Ничья'
    end
  end
end
