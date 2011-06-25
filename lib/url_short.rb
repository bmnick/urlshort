require 'sinatra/base'

class UrlShort < Sinatra::Base
  get '/' do
    'Hello UrlShort!'
  end
end
