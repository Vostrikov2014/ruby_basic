=begin
Заполнить массив числами фибоначчи до 100
=end

#массив чисел Фибоначчи
fibonacci_numbers = [0]

#число Фибоначчи
fibonacci_number = 1

while fibonacci_number < 100 do
  fibonacci_numbers.push fibonacci_number
  fibonacci_number = fibonacci_numbers[-1] + fibonacci_numbers[-2]
end

puts fibonacci_numbers

