require 'socket'

class WebBrowser
	
	def initialize(host, port)
		@host = host
		@port = port
	end
	
	def send_get_request(path)
		request = "GET #{path} HTTP/1.0\r\n\r\n"	

		socket = TCPSocket.open(@host, @port)
		socket.print(request)

		response = socket.read

		return response
	end

	def print_response_content(response)
		# relying on having an empty line between the HTTP response header and the content
		response = response.slice(response.index("\r\n\r\n")..-1)
		response.gsub!("\r\n\r\n", "")
		puts response
	end
end

thor = WebBrowser.new("localhost", 2000)
response = thor.send_get_request("/index.html")
thor.print_response_content(response)
