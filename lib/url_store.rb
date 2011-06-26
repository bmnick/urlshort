class UrlStore
	def self.instance
		@@instance ||= UrlStore.new
	end

	def initialize
		puts "hello"
		@mappings = Hash.new
	end

	def add_mapping slug, address
		@mappings[slug] = address
	end

	def get_mapping slug
		@mappings[slug]
	end
end
