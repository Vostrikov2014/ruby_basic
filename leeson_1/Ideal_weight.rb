=begin
Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле (<рост> - 110) * 1.15,
после чего выводит результат пользователю на экран с обращением по имени. Если идеальный вес получается отрицательным,
то выводится строка "Ваш вес уже оптимальный"
=end

print 'Введите имя: '
name = gets.chomp
print 'Введите рост: '
weight = gets.chomp.to_i

ideal_weight = (weight - 110) * 1.15

if ideal_weight < 0
  puts "#{name}. Ваш вес уже оптимальный"
else
  puts "#{name}. Ваш вес неидеален"
end