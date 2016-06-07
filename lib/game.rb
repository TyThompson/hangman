class Game < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  attr_accessor :games_played

  def initialize(name)
    @name = name
    @games_won = 0
    @games_played = 0
    @guessed_letters = []
    @word = ""
  end

  def questions(blank_array, guessed_letters, guesses)
	  puts "Hangman: ", blank_array.join(" ")
	  puts "Wrong letters: ", guessed_letters.join(" ")
	  puts "Guesses left: #{guesses}"
	  puts
	  puts "Guess a letter: "
	end

  def get_input
    input = gets.chomp.downcase
	  return input
  end

  def guess(input, guessed_letters, guesses, word_array, blank_array)
    guesses -=1
    if guessed_letters.include?(input)
      puts "You already guessed #{input}. Please type a new letter"
      return false
    elsif word_array.include?(input)
      puts "That letter was found in the hidden word!"
      count = 0
      word_array.each do |letter|
        if input == letter
          blank_array[count] = input
        end
      count += 1
      end
      return false
    else
      puts "That letter is not in the hidden word!"
      guessed_letters << input
      return true
    end
  end

  #victory condition
  def win(word)
    puts "You won! The word was: #{word}"
    puts
    gameover = true
    @games_won += 1
    return gameover
  end

  #losing condition
  def lose(word)
    puts "You lost! The word was: #{word}"
    puts
    gameover = true
    return gameover
  end

  def play(number_of_guesses)
    @word = File.read("words.txt").downcase.split("\n").sample
    blank_array = Array.new(@word.length, "_")
    guesses = number_of_guesses
    word_array = @word.downcase.split("")
    gameover = false

    until gameover == true
      questions(blank_array, @guessed_letters, guesses)

      input = get_input

      if guess(input, @guessed_letters, guesses, word_array, blank_array)
        guesses -=1
      end

      if word_array == blank_array  || input == @word
        gameover = win(@word)
      end

      if guesses == 0
        gameover = lose(@word)
      end
    end
    puts "End of game"
    @games_played += 1
    @guessed_letters = []

    puts "Games Won:", @games_won
    puts "Games Played:", @games_played
  end
end
