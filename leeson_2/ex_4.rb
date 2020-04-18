=begin
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

vowels_hash = {}

alphabet = ('a'..'z')
vowels = ['a', 'e', 'i', 'o', 'u']

=begin
еще возможн так...  как обычно объявляют массив в такой ситуации?
vowels = %w[a e i o u]
vowels = 'aeiou'.chars
=end

alphabet.each.with_index() do |char, i|
  vowels_hash[char] = i if vowels.include?(char)
end

puts vowels_hash