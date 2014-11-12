require 'rubygems'
require 'bundler/setup'

Bundler.require

require './models/TodoItem'
require './models/User'

if ENV['DATABASE_URL']
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
    ActiveRecord::Base.establish_connection(
        :adapter  => 'sqlite3',
        :database => 'db/development.db',
        :encoding => 'utf8'
    )
end

get '/' do
    @users = User.all.order(:name)
    erb :userList
end

get '/:user' do
    @user = User.find(params[:user])
    @tasks = @user.todo_items.order(:due)
    erb :todoList
end

post '/new_user' do
      @user = User.create(params)
        redirect '/'
end

get '/delete_user/:user' do
      User.find(params[:user]).destroy
        redirect '/'
end

post '/:user/new_item' do
      User.find(params[:user]).todo_items.create(description: params[:task], due: params[:date])
        redirect "/#{params[:user]}"
end

get '/delete_item/:item' do
    @todo_item = TodoItem.find(params[:item])
    @user = @todo_item.user
    @todo_item.destroy
    redirect "/#{@user.id}"
end

helpers do
    def blank?(x)
    x.nil? || x == ""
    end
end
