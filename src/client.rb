require 'socket'
load 'packet.rb'

begin
  c = TCPSocket.new "localhost", 9919
rescue
  puts "unable to connect"
end


def recv(socket)
	p = NetPacket.new

	p.type			= socket.read(4).unpack('i')[0]
	p.timestamp		= socket.read(4).unpack('i')[0]
	size			= socket.read(4).unpack('i')[0]

	for i in 0..size-1
		name = socket.read(16).unpack('a16')[0]
		size = socket.read(4).unpack('i')[0]
		data = socket.read(size).unpack('i')[0]

		d = NetData.new(data, size)

		p.data[name] = d
	end

	return p
end

def send(socket, packet)
	header = [packet.type, packet.timestamp, packet.data.size].pack('i*')

	socket.send header, 0

	packet.data.each do |name, datum|
		socket.send [name].pack('a16'), 0
		socket.send [datum.size].pack('i'), 0

		puts datum.size

		case datum.data.class.name
			when "String"
				socket.send [datum.data].pack('a' + (datum.data.size+1).to_s), 0
			when "Fixnum"
				socket.send [datum.data].pack('i'), 0
			when "Float"
				socket.send [datum.data].pack('f'), 0
		end
	end
end

p = NetPacket.new(300)
p.timestamp = 0
p.data["id"] = NetData.new("pjc0247")
p.data["pw"] = NetData.new("asdf")

send(c, p)

while true
	p = recv(c)	

	puts "recv " + p.type.to_s

	case p.type
		when 100
#			send c, nil
	end
end

c.close