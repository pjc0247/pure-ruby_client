class Data
	def initialize
		@data = Hash.new
	end

	def size
		@data.size
	end

	def get(idx)
		@data[idx]	
	end
	def set(idx, value)
		@data[idx] = value
	end

	def [](idx)
		get idx
	end
	def []=(idx,value)
		set idx, value
	end
end

class Packet
	attr_accessor :type, :timestamp
	attr_accessor :data

	def initialize
		@data = Data.new
	end
end