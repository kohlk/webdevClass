require 'rubygems'
require 'bundler/setup'
require 'pry'

Bundler.require

require './models/TodoItem'

ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'db/development.db',
    :encoding => 'utf8'
)

get '/' do
    erb :index
end

#post section sourced from qrohlf
post '/' do  
    TodoItem.create(description: params[:thing], due: params[:date])
    redirect '/todo'   
end

get '/todo' do
    @things = TodoItem.all.order(:due) # @things is an instance variable
    erb :todo
end

#get '/delete/:id' do
#    TodoItem.find(params[:id]).destroy
#end


helpers do
    def blank?(x)
    x.nil? || x == ""
    end
end
