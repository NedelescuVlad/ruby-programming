require_relative 'saves_manager'
require_relative 'hangman'
require_relative 'game_manager'

class GameMenu
	
	OPTION = {NEW_GAME: 1, LOAD_GAME: 2}
	
	def launch
		puts "Welcome to hangman, an interactive human vs AI game!"
		display_menu
		hangman = nil
		loop do
			user_choice = prompt_for_menu_choice
			hangman = get_hangman_from_user_choice(user_choice)
			break if hangman != nil
		end

		GameManager.new(hangman).start_game		

	end

	private def display_menu
		puts "Please choose an action"
		puts "1. Start a new game"	
		puts "2. Load a game"
	end

	private def get_hangman_from_user_choice(user_choice)

		if user_choice == OPTION[:NEW_GAME]
			hangman = Hangman.new
		elsif user_choice == OPTION[:LOAD_GAME]
			hangman = process_load_request
		else
			puts "Invalid input, only '1' and '2' are accepted"
			display_menu
		end

		return hangman
	end

	private def process_load_request
		puts "Please write the name of your saved game"	

		hangman = nil
		loop do
			saved_game_name = gets.chomp
			hangman = SavesManager.load_game(saved_game_name)
			break if hangman != nil
			puts "Save not found! Please try again."
		end 

		return hangman
	end
	private def prompt_for_menu_choice
		gets.chomp.to_i
	end
end

GameMenu.new.launch
