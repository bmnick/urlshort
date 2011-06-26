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
		@redis.set slug, address
		slug
	end

	def get_mapping slug
		@redis.get slug
	end
end
