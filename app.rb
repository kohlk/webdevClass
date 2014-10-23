require 'rubygems'
require 'bundler/setup'

Bundler.require

require './models/TodoItem'

ActiveRecord::Base.establish_connection(
    :adapter  => 'sqlite3',
    :database => 'db/development.db',
    :encoding => 'utf8'
)

get '/' do
    @things = TodoItem.all.order(:due) # @things is an instance variable
    erb :index
end

#post section sourced from qrohlf
post '/' do  
    TodoItem.create(description: params[:thing], due: params[:date])
    redirect '/todo'   
end

helpers do
    def blank?(x)
    x.nil? || x == ""
    end
end
