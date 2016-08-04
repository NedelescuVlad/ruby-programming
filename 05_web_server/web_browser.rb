require 'socket'
require 'json'

class WebBrowser
	
	def initialize(host, port)
		@host = host
		@port = port
	end


	def run
		while true
			display_menu
			option = (prompt "Please choose one of the above options").to_i

			case option
			when 1 then #process get request
				path = prompt "Path to file: "
				response = send_get_request(path)
				print_response_content(response)
			when 2 then #process post request
				response = send_post_request(create_viking.to_json)	
				print_response_content(response)
			when 3 then break
			end
		end	
		puts "Bye!"
	end

	def create_viking
		puts "Beep Boop... Making VIKING"
		print "Name: "
		name = gets.chomp
		print "Email: "
		email = gets.chomp

		{viking: {name: name, email: email}}
	end

	def display_menu
		puts "Web Browser"
		puts "==========="
		puts "1. Send GET Request"
		puts "2. Send POST Request"
		puts "3. Quit\r\n"
	end
	
	def prompt(message)
		puts message
		response = gets.chomp
		return response
	end

	def send_get_request(path)
		request = "GET #{path} HTTP/1.0\r\n\r\n"	

		socket = TCPSocket.open(@host, @port)
		socket.print(request)

		response = socket.read

		return response
	end

	def send_post_request(json_data_hash)
		request = String.new

		request << "POST HTTP/1.0\r\n"
		request << "Content-Length: #{json_data_hash.length}\r\n\r\n"
		request << "#{json_data_hash}"

		socket = TCPSocket.open(@host, @port)
		socket.print(request)	
	end

	def print_response_content(response)
		# this relies on having an empty line between the HTTP response header and the content
		response = response.slice(response.index("\r\n\r\n")..-1)
		response.gsub!("\r\n\r\n", "")
		puts response
	end

	private :display_menu, :send_get_request, :send_post_request, :print_response_content
end

browser = WebBrowser.new("localhost", 2000)
browser.run
