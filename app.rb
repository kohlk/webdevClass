require 'rubygems'
require 'bundler/setup'

Bundler.require

get '/' do
    erb :index
end

get '/todo' do

    file_contents = File.read('todo.txt')

    lines = file_contents.split("\n")

    lines.each do |line|
        thing, date = line.split("-")
        puts "ToDo -  #{date}: #{thing}"
    end
end
