=begin
Площадь треугольника. Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.
=end

print 'Введите основание: '
base = gets.chomp.to_f
print 'Введите высоту: '
weight = gets.chomp.to_f

#преобразование числа к типу флоат
puts "Площадь треугольника: #{1/2.0 * base * weight}"