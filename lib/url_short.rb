require "rubygems"
require "bundler/setup"

require 'sinatra/base'
require 'haml'
require File.expand_path(File.join(File.dirname(__FILE__), "url_store"))

class UrlShort < Sinatra::Base
	configure do
		set :haml, :format => :html5

		uri = URI.parse(ENV["REDISTOGO_URL"])
		STORE = UrlStore.new(uri.host, uri.port, uri.password)
	end

	configure :production do
		BASEURL = 'http://bmnic.us'
	end

	configure :test, :development do
		BASEURL = 'http://urshort.dev'
	end

  get '/' do
    haml :index
  end

	get '/results/:slug' do |slug|
		@link = BASEURL + '/' + slug
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
		redirect "/results/#{slug}"
	end
end
