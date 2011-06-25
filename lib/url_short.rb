require 'sinatra/base'

class UrlShort < Sinatra::Base
  get '/' do
    haml :index
  end
end
