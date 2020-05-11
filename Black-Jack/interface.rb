%w[game hand].each { |f| require_relative f }

class Interface

  def start_game

    print 'Введите имя игрока: '
    name = gets.chomp
    @game = Game.new(name)
    @hand = Hand.new(@game)

    loop do
      @stop = false
      @game.new_game
      user_make_game
      @game.dealer_make_game unless @stop
      result_game
      open_cards
      puts ''
      puts 'Введите: 1 - продолжить, 2 - выход'
      entered_number = gets.chomp.to_i
      next if entered_number == 1
      break if entered_number == 2
    end
  end

  def user_make_game
    puts ''
    print 'Карты:'
    @game.user.cards.each { |card| print " #{card.name}"}
    puts ''
    puts "Очки: #{@game.user.score}"
    puts ''
    puts 'Введите: 1 - пропустить ход, 2 - добавить карту, 3 - открыть карты'
    entered_number = gets.chomp.to_i

    return if entered_number == 1

    @game.deck.add_card(@game.user) if entered_number == 2
    @stop = true if entered_number == 3
  end

  def result_game
    puts ''
    print 'Ваши карты:'
    @game.user.cards.each { |card| print " #{card.name}"}
    puts ''
    puts "Ваши очки: #{@game.user.score}"
    print 'Карты дилера:'
    @game.dealer.cards.each { |card| print " #{card.name}"}
    puts ''
    puts "Очки дилера: #{@game.dealer.score}"
  end

  def open_cards
    win = @hand.user_winner
    if win
      puts ''
      puts "Выиграл #{win.name}!"
    else
      puts ''
      puts 'Ничья'
    end
  end
end