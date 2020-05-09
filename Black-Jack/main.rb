require_relative 'game'

puts 'Вы запустили игру Black Jack!'
puts 'Обозначение масти: + - крести, <3 - черви, ^ - пики, <> - бубны'

print 'Введите имя игрока: '
name = gets.chomp
Game.new(name).start_game
