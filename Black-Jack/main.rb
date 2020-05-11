require_relative 'interface'

puts 'Вы запустили игру Black Jack!'
puts 'Обозначение масти: + - крести, <3 - черви, ^ - пики, <> - бубны'

Interface.new.start_game
