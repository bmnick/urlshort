require 'sinatra/base'

class UrlShort < Sinatra::Base
	@@baseurl = 'http://urlshort.dev'

  get '/' do
    haml :index
  end

	get '/results/:slug' do |slug|
		@link = @@baseurl + '/' + slug
		haml :results
	end

	post '/' do
		redirect "/results/#{params[:slug]}"
	end
end
