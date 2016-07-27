require 'socket'

hostname = 'localhost'
port = 2000
path = "/index.html"
request = "GET #{path} HTML/1.0\r\n\r\n"

socket = TCPSocket.open(hostname, port)
socket.print(request)

response = socket.read
puts response
socket.close
