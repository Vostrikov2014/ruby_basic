class User < Users

  def initialize(name)
    super
  end

  def set_cards
    super
    puts @cards
  end

  def make_game
    puts "Карты: #{@cards}"
    puts "Очки: #{@score}"
    puts ' Введите: 1 - пропустить ход, 2 - добавить карту, 3 - открыть карты'
    entered_number = gets.chomp.to_i

    return if entered_number == 1
    add_card if entered_number == 2
    open_cards if entered_number == 3
  end
end