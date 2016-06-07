require "pry"
require "./db/setup"
require "./lib/all"

def get_name
  puts "What is your name?"
  name = gets.chomp.capitalize
  if Game.where(name: name).length > 0
    puts "GAME FOUND ~~~~~~~~~~~~~~"
    return Game.where(name: name)
  else
    puts "NEW GAME ~~~~~~~~~~~~~~~~"
    return Game.create!(name)
  end
end
hang = get_name
hang.play(6)
hang.save

hang = get_name
hang.play(6)
hang.save

puts Game.all.length
