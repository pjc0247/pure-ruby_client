require 'socket'
load 'packet.rb'

begin
  c = TCPSocket.new "localhost", 9919
rescue
  puts "unable to connect"
end


def recv(socket)
	p = Packet.new

	p.type = socket.read(4).ord
	p.timestamp = socket.read(4).ord
	size = socket.read(4).ord

	for i in 0..size-1
		name = socket.read(16)
		size = socket.read(4).ord
		data = socket.read(size)

		d = Data.new(name, size, data)

		p.data[name] = d
	end

	return p
end

def send(socket, packet)
	header = [packet.type, packet.timestamp, packet.data.size].pack('i*')

	socket.send header, 0
end

while true
	p = recv(c)	

	case p.type
		when 100
			send c, nil
	end
end

c.close