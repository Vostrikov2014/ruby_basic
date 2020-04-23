require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'

moscow = Station.new('Moscow')
gagarin = Station.new('Gagarin')
smolensk = Station.new('Smolensk')

moscow_smolensk = Route.new(moscow, smolensk)
moscow_smolensk.add_station(gagarin)

puts moscow_smolensk.stations

