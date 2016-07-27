require 'socket'

STATUS_CODE = {OK: 200, FILE_NOT_FOUND: 404, ILLEGAL_VERB: 500}

class Server

	PORT = 2000
	
	def initialize
		server = TCPServer.open(PORT)
		
		loop do
			socket = server.accept
			request = socket.gets
			status_code = get_status_code(request)
			response = generate_response_from_status_code(status_code)
			socket.puts(response)
			socket.close
		end
	end


	def generate_response_from_status_code(status_code)
		status_description = STATUS_CODE.key(status_code)

		status_line = "#{status_code} #{status_description}\r\n"
		
		response = String.new
		header = String.new
		content = String.new

		if status_code == STATUS_CODE[:OK]

			index_file_content = read_index_file

			header << "Content-Type: text/html\r\n"
			header << "Content-Length: #{index_file_content.length}\r\n"
			
			content << index_file_content

		elsif status_code == STATUS_CODE[:FILE_NOT_FOUND]

			header << "Content-Type: Error\r\n"

			content << "404 - File not Found\r\n"

		end	

		response << status_line
		response << header
		response << "\r\n" # new line between header and content
		response << content

		return response
	end

	def read_index_file
		result = ""
		File.open("./index.html", "r") do |file|
			file.each_line do |line|
				result += line
			end
		end

		return result
	end

	def get_status_code(request)
		request_parts = request.split
		verb, path, protocol = request_parts
		
		case verb
		when "GET"
			if path == "/index.html"
				return STATUS_CODE[:OK]
			else
				return STATUS_CODE[:FILE_NOT_FOUND]
			end
		when "POST"
			# process POST request	
		else
			return STATUS_CODE[:ILLEGAL_VERB]
		end
	end
end

Server.new
