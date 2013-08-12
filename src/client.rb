require 'socket'
load 'packet.rb'

begin
  c = TCPSocket.new "localhost", 9919
rescue
  puts "unable to connect"
end



def toNumber(data)
	data.unpack('i')[0]
end
def toString(data, length=nil)
	if length == nil
		ret = data.data.unpack('a' + data.size.to_s)[0]
	else
		ret = data.unpack('a' + length.to_s)[0]
	end

	ret.split("\x00")[0]
end

def NetRecvNumber(socket)
	toNumber( socket.read(4) )
end
def NetRecvString(socket, length)
	toString( socket.read(length) , length)
end

def recv(socket)
	p = NetPacket.new

	p.type			= NetRecvNumber(socket)
	p.timestamp		= NetRecvNumber(socket)
	size			= NetRecvNumber(socket)

	for i in 0..size-1
		name = NetRecvString(socket, 16)
		size = NetRecvNumber(socket)
		data = socket.read(size)

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
		when 301
			p p.data["reason"]
			puts toString( p.data["reason"] )
	end
end

c.close