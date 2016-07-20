class Hangman
	
	# generous enough
	MAX_GUESSES = 15	

	def initialize
		@selected_word = select_word_from_file
		@guessed_letters = []
		@guesses_made = 0
	end	
	
	def play
		while (user_has_guesses? && !user_guessed_correctly?) 
			@guesses_made += 1
		
			print_guessed_word
			print_remaining_guesses
			user_input = prompt_for_input
			parse_input(user_input)

			puts ""
		end

		print_outcome
	end

	private def print_outcome
		if user_guessed_correctly?
			puts get_winning_message
		else
			puts get_losing_message	
		end
	end

	private def get_winning_message
		"Congratulations! You have correctly guessed: #{get_guessed_word}"
	end

	private def get_losing_message
		"Game over! Your guess was: #{get_guessed_word}\nThe sought word was: #{@selected_word}"
	end

	private def user_has_guesses?
		@guesses_made < MAX_GUESSES
	end
	
	private def parse_input(user_input)
		if user_input.length == 1
			@guessed_letters << user_input
		elsif user_input.length > 1
			if user_input == @selected_word 
				exit(get_winning_message)
			else
				abort(get_losing_message)
			end

		else
			# user_input is 0, unintended method call (before prompt_for_input)
		end
	end

	private def prompt_for_input
		user_input = ""
		while user_input == ""
			puts "Take your guess"
			user_input = gets.chomp.downcase
		end
		return user_input
	end	

	private def print_remaining_guesses
		puts "[GUESSES] #{MAX_GUESSES - @guesses_made + 1} remaining"
	end

	private def user_guessed_correctly?
		# check if all letters have been guessed
		(@selected_word.split('').uniq - @guessed_letters).empty?
	end

	private def select_word_from_file
		result = nil
		loop do 
			result = File.readlines('5desk.txt').sample.chomp
			break if result.length >= 5 && result.length <= 12
		end 
		return result.downcase
	end

	private def get_guessed_word
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
	
	private def print_guessed_word
		puts "The word is: #{get_guessed_word}"
		puts ""
	end
end

Hangman.new.play
