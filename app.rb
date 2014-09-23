require 'rubygems'
require 'bundler/setup'

Bundler.require

get '/' do
    erb :index
end

get '/todo' do
    erb :todo
end
