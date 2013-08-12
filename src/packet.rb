class NetData
	attr_accessor :data, :size

	def initialize(data=nil, size=nil)
		@data = data

		if size == nil
			if data.class == String
				@size = data.size+1			
			else
				@size = data.size
			end
		else
			@size = size
		end
	end
end

class NetPacket
	attr_accessor :type, :timestamp
	attr_accessor :data

	def initialize(type = 0)
		@type = type
		@data = Hash.new
	end
end