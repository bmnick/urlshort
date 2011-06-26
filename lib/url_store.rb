require 'digest/crc16'

class UrlStore
	def initialize
		@mappings = Hash.new
	end

	def add_mapping slug, address
		if slug.length == 0
			slug = Digest::CRC16.hexdigest(address)
		end
		@mappings[slug] = address
		slug
	end

	def get_mapping slug
		@mappings[slug]
	end
end
