require 'rubygems'
require 'bundler/setup'

Bundler.require

get '/' do
    erb :index
end

#post section sourced from qrohlf
post '/' do         
    File.open("todo.txt", "a") do |file|
        unless blank? params[:date]
            file.puts "#{params[:thing]} - #{params[:date]}" 
        else
            file.puts "#{params[:thing]}"
        end
    end
    redirect '/'
end

get '/todo' do
    file_contents = File.read("todo.txt")
    lines = file_contents.split("\n") 
    @things = []                  #@task from qrohlf's example
    lines.each do |line| 
        thing, date = line.split("-") 
        @things << [thing, date]
    end 
    erb :todo
end

helpers do
    def blank?(x)
    x.nil? || x == ""
    end
end
