require 'socket'

begin
  c = TCPSocket.new "localhost", 9919
rescue
  puts "unable to connect"
end

puts c.read(4)
