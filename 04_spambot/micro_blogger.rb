require 'jumpstart_auth'
require 'bitly'

class MicroBlogger

	attr_reader :client
	def initialize
		puts "Initializing MicroBlogger"
		@client = JumpstartAuth.twitter
	end

	def run
		puts "Welcome to the JSL Twitter Client!"
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp 
			parts = input.split(" ")
			command = parts[0]

			case command
			when 'q' then puts "Goodbye!"
			when 't' then tweet(parts[1..-1].join(" "))
			when 's' then shorten(parts[1])
			when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
			when 'dm' then dm(parts [1], parts[2..-1].join(" "))
			when 'spam' then spam_my_followers(parts[1..-1].join(" "))
			when 'elt' then everyones_last_tweet
			else
				puts "Sorry, I don't know how to #{command}"
			end
		end
	end

	private 
		def tweet(message)
			if legal_length(message)
				@client.update(message)
			else
				puts "Illegal message length. Needs to be 140 characters or less"
			end
		end

		def dm(target, message)
			puts "Trying to send direct message to #{target}"
			puts message

			screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
			if screen_names.include?(target)
				message = "d @#{target}#{message}"
				tweet(message)
			else
				puts "Cannot send direct message."
				puts "Check that #{target} is valid and in your followers list."
			end
		end

		def spam_my_followers(message)
			followers = followers_list
			followers.each do |follower|
				dm(follower, message)
			end
		end

		def everyones_last_tweet
			friends = @client.friends
			# @client.friends returns an array of unique identifiers for each friend
			# replace those with real user objects
			friends = friends.map {|friend| @client.user(friend)}
			friends.sort_by {|friend| friend.screen_name.downcase}
			friends.each do |friend|
				# find each friend's last message
				last_tweet = friend.status
				last_message = last_tweet.text
				# find the last_tweet post date
				post_date = last_tweet.created_at
				# format the post date to i.e. 'Wednesday, Jul 19'
				formatted_post_date = post_date.strftime("%A, %b %d")
				# print each friend's screen_name and post date
				puts "#{friend.name} said this on #{formatted_post_date}..."
				# print each friend's last message
				puts last_message

				puts "" # Just print a blank line to separate people
			end
		end

		def legal_length(message)
			message.length <= 140
		end

		def followers_list
			screen_names = []
			@client.followers.each do |follower|
				screen_names << @client.user(follower).screen_name
			end
			return screen_names
		end

		def shorten(original_url)
			#Shortening code
			Bitly.use_api_version_3
			bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
			puts "Shortening this url: #{original_url}"
			return bitly.shorten(original_url).short_url
		end
end

blogger = MicroBlogger.new
blogger.run
