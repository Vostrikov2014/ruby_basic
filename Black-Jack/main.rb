require_relative 'game'

puts 'Вы запустили игру Black Jack!'

print 'Введите имя игрока:'
name = gets.chomp

game = Game.new(name)
game.start_game
