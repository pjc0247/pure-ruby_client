class Data
	attr_accessor :data, :size
	attr_accessor :name

	def initialize(name=nil, size=nil, data=nil)
		@name = name
		@size = size
		@data = data
	end
end

class Packet
	attr_accessor :type, :timestamp
	attr_accessor :data

	def initialize
		@data = Hash.new
	end
end