class Hangman
	
	# generous enough
	MAX_GUESSES = 15	

	attr_reader :selected_word

	def initialize
		@selected_word = select_word_from_file
		@guessed_letters = []
		@made_guesses = 0
	end	

	def process_guess(user_input)
		if user_input.length == 1  && !@guessed_letters.include?(user_input)
			@guessed_letters << user_input
		elsif user_input.length > 1
			if user_input == @selected_word 
				exit(winning_message)
			else
				abort(losing_message)
			end

		else
			# user_input is empty, unintended method call (before GameManager.prompt_for_input)
		end
	end
	
	def increment_made_guesses
		@made_guesses += 1
	end
	
	def user_guessed_correctly?
		# check if all letters have been guessed
		(@selected_word.split('').uniq - @guessed_letters).empty?
	end
	
	def user_has_guesses?
		@made_guesses < MAX_GUESSES
	end
	
	# returns the playet's progress in guessing the word
	def get_guessed_word
		guessed_word = ""

		@selected_word.split('').each do |letter|
			if @guessed_letters.include?(letter)
				guessed_word << letter
			else
				guessed_word << "_"
			end
		end
		return guessed_word
	end

	def get_remaining_guesses
		MAX_GUESSES - @made_guesses 
	end

	def winning_message
		"Congratulations! You have correctly guessed: #{get_guessed_word}"
	end

	def losing_message
		"Game over! Your guess was: #{get_guessed_word}\nThe sought word was: #{selected_word}"
	end

	private def select_word_from_file
		result = nil
		loop do 
			result = File.readlines('5desk.txt').sample.chomp
			break if result.length >= 5 && result.length <= 12
		end 
		return result.downcase
	end	
end
