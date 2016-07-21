require 'yaml'
require_relative 'hangman'
require_relative 'saves_manager'

# Class for handling hangman gameplay and user interaction
class GameManager

	SAVE_COMMAND = "save_game"

	def initialize(hangman)
		@hangman = hangman 
	end

	def start_game

		display_game_instructions()
		while (@hangman.user_has_guesses? && !@hangman.user_guessed_correctly?) 
			
			print_guessed_word()
			print_remaining_guesses()
			user_input = prompt_for_input()
			if user_input == SAVE_COMMAND
				process_save_command
			else
				@hangman.process_guess(user_input)
				@hangman.increment_made_guesses()
			end

			puts ""
		end

		print_outcome()
	end

	private def display_game_instructions
		puts "\n[NOTE] Write '#{SAVE_COMMAND}' at any time to abort the game and save your progress"
		puts "[NOTE] Your saves can be found in the '#{SavesManager::SAVES_DIR}' directory under the root of this program\n\n"
	end

	private def process_save_command
		puts "Save game as: "
		save_name = gets.chomp
		SavesManager.save_game(@hangman, save_name)

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
			puts @hangman.winning_message
		else
			puts @hangman.losing_message	
		end
	end

end
