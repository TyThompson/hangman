dict_words = File.read("/usr/share/dict/words").downcase.split("\n")
word = dict_words.sample
word_array = word.downcase.split("")
blank_array = Array.new(word.length, "_")
gameover = false
guesses = 6
input = ""
guessed = []
letter_check = 0
letter_pos = nil
until gameover do
  puts
  print "Hangman: ", blank_array.join(" ")
  puts
  print "Guessed letters: ", guessed.join(" ")
  puts
  print "Guesses left: #{guesses}"
  guesses -= 1
  puts
  puts "Guess a letter: "
  input = gets.chomp.downcase
  if guessed.include?(input) || input.length > 1
    puts "Please type a new letter"
    guesses += 1
  elsif word_array.include?(input)

    guesses += 1
    puts "That letter was found!"
    count = 0
    word_array.each do |letter|
      if input == letter
        blank_array.delete_at(count)
        blank_array.insert(count, input)
      end
      count += 1
    end
  end
  #victory condition
  if word_array == blank_array
    gameover = true
    puts
    print "You won! The word was: #{word}"
    puts
    break
  end
  #losing condition
  if guesses == 0
    gameover = true
    puts
    print "You lost! The word was: #{word}"
    puts
    break
  end
  guessed << input
end
