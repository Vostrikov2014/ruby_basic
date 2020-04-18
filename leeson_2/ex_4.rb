=begin
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

vowels_hash = {}
vowels = ['a', 'e', 'i', 'o', 'u']

=begin
еще возможн так...  как обычно объявляют массив в такой ситуации?
vowels = %w[a e i o u]
vowels = 'aeiou'.chars

можно так же объявить диапазон но опять же хз как лучше?
alphabet = ('a'..'z')
=end

('a'..'z').each.with_index() { |char, i| vowels_hash[char] = i if vowels.include?(char) }

puts vowels_hash