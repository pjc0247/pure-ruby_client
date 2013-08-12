class Data
	attr_accessor :data, :size

	def initialize(data=nil, size=nil)
		@data = data

		if size == nil
			@size = data.size
		else
			@size = size
		end
	end
end

class Packet
	attr_accessor :type, :timestamp
	attr_accessor :data

	def initialize(type = 0)
		@type = type
		@data = Hash.new
	end
end