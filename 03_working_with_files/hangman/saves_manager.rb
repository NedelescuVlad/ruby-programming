require 'yaml'
class SavesManager
	
	SAVES_DIR = "saved_games"

	def self.save_game(hangman_object, game_name)
		Dir.mkdir(SAVES_DIR) unless Dir.exists?(SAVES_DIR)

		serialized_hangman = YAML::dump(hangman_object)
		File.open(get_save_path(game_name), 'w') do |file|
			file.puts serialized_hangman	
		end
	end

	def self.load_game(game_name)	
		if File.exists? (get_save_path(game_name))
			hangman_object = YAML.load_file(get_save_path(game_name))	
			return hangman_object
		else
			return nil
		end
	end

	def self.get_save_path(game_name)
		"#{SAVES_DIR}/#{game_name}"
	end

	private_class_method :get_save_path
end
