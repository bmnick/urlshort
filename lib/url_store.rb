require 'digest/crc16'
require 'redis'

class UrlStore
	def initialize(host, port, password)
		@redis = Redis.new(:host => host, :port => port, :password => password)
	end

	def add_mapping slug, address
		if slug.length == 0
			slug = Digest::CRC16.hexdigest(address)
		end

		if validate(address)
			@redis.set slug, address
		else
			slug = nil
		end

		slug
	end

	def get_mapping slug
		@redis.get slug
	end

	def validate url
		begin
			uri = URI.parse(url)
			if (uri.class != URI::HTTP && uri.class != URI::HTTPS)
				return false
			end
		rescue URI::InvalidURIError
			return false
		end
		true
	end
	
end
