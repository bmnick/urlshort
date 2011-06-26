require "rubygems"
require "bundler/setup"

require 'sinatra/base'
require 'haml'
require File.expand_path(File.join(File.dirname(__FILE__), "url_store"))

class UrlShort < Sinatra::Base
	STORE = UrlStore.new
	@@baseurl = 'http://urlshort.dev'
	set :haml, :format => :html5

  get '/' do
    haml :index
  end

	get '/results/:slug' do |slug|
		@link = @@baseurl + '/' + slug
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
		STORE.add_mapping params[:slug], params[:url]
		redirect "/results/#{params[:slug]}"
	end
end
