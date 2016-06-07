require "pry"
require "./db/setup"
require "./lib/all"

def get_name
  puts "What is your name?"
  name = gets.chomp.capitalize
  return name
end

hang = Game.new(get_name)

hang.play(6)
hang.play(6)
