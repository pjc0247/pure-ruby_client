class NetData
	attr_accessor :data, :size

	def initialize(data=nil, size=nil)
		@data = data

		# 사이즈가 입력되지 않았으면 자동으로 지정
		if size == nil
			
			# 문자열일 경우 끝에 널문자 1 바이트 추가
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