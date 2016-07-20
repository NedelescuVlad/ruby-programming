require_relative 'hangman'

# Class for handling input/output interaction with the hangman player
class GameManager
	def initialize(hangman)
		@hangman = hangman
	end

	def start_game
		while (@hangman.user_has_guesses? && !@hangman.user_guessed_correctly?) 
			
			@hangman.increment_made_guesses

			print_guessed_word
			print_remaining_guesses
			user_input = prompt_for_input
			@hangman.parse_input(user_input)

			puts ""
		end

		print_outcome
	end

	private def prompt_for_input
		# prompt until user enters a non-empty string
		user_input = ""
		while user_input == ""
			puts "Take your guess"
			user_input = gets.chomp.downcase
			if user_input == "" 
				puts "Guess cannot be empty"
			end
		end
		return user_input
	end	

	private def print_guessed_word
		puts "The word is: #{@hangman.get_guessed_word}"
		puts ""
	end

	private def print_remaining_guesses
		puts "[GUESSES] #{@hangman.get_remaining_guesses} remaining"
	end

	private def print_outcome
		if @hangman.user_guessed_correctly?
			puts winning_message
		else
			puts losing_message	
		end
	end

	private def winning_message
		"Congratulations! You have correctly guessed: #{@hangman.get_guessed_word}"
	end

	private def losing_message
		"Game over! Your guess was: #{@hangman.get_guessed_word}\nThe sought word was: #{@hangman.selected_word}"
	end

end

game_manager = GameManager.new(Hangman.new)
game_manager.start_game
