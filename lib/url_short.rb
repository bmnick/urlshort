require "rubygems"
require "bundler/setup"

require 'sinatra/base'
require 'haml'
require 'sass'
require File.expand_path(File.join(File.dirname(__FILE__), "url_store"))

class UrlShort < Sinatra::Base
	configure do
		set :haml, :format => :html5

		url = ENV["REDISTOGO_URL"]
		url ||= 'redis://localhost:6379'
		uri = URI.parse(url)

		STORE = UrlStore.new(uri.host, uri.port, uri.password)
	end

  get '/' do
    haml :index
  end

	get '/style.css' do
		sass :style
	end

	get '/results/:slug' do |slug|
		@link = url("/#{slug}")
		haml :results
	end

	get '/:slug' do |slug|
		redirect_path = STORE.get_mapping slug
		if redirect_path
			redirect redirect_path, 301
		else
			haml :notfound
		end
	end

	post '/' do
		slug = STORE.add_mapping params[:slug], params[:url]
		if slug
			redirect "/results/#{slug}"
		else
			haml :invalid
		end
	end
end
