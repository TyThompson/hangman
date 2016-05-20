def questions(blank_array, guessed, guesses)
  puts
  print "Hangman: ", blank_array.join(" ")
  puts
  print "Wrong letters: ", guessed.join(" ")
  puts
  print "Guesses left: #{guesses}"
  puts
  puts "Guess a letter: "
end

def get_input
  input = gets.chomp.downcase
  return input
end

def guess(input, guessed, guesses, word_array, blank_array)
  guesses -=1
  if guessed.include?(input)
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
    guessed << input
    return true
  end
end

#victory condition
def win(word)
  puts
  print "You won! The word was: #{word}"
  puts
  gameover = true
  return gameover
end

#losing condition
def lose(word)
  puts
  print "You lost! The word was: #{word}"
  puts
  gameover = true
  return gameover
end

def play(w, number_of_guesses)
  word = w
  blank_array = Array.new(word.length, "_")
  guessed = []
  guesses = number_of_guesses
  word_array = word.downcase.split("")
  gameover = false

  until gameover == true
    questions(blank_array, guessed, guesses)

    input = get_input

    if guess(input, guessed, guesses, word_array, blank_array)
      guesses -=1
    end

    if word_array == blank_array  || input == word
      gameover = win(word)
    end

    if guesses == 0
      gameover = lose(word)
    end
  end
  puts "End of game" if gameover
end

play(File.read("words.txt").downcase.split("\n").sample, 6)
