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

#
get '/:user' do
    @user = User.find(params[:user])
    @tasks = @user.todo_items.order(:due)
    erb :todo
end

#
post '/new_user' do
      @user = User.create(params)
        redirect '/'
end

#
get '/delete_user/:user' do
      User.find(params[:user]).destroy
        redirect '/'
end

post '/:user/new_item' do
      User.find(params[:user]).todo_items.create(description: params[:task], due: params[:date])
        redirect "/todo/#{params[:user]}"
end

# since task ids are
get '/delete_item/:item' do
    @todo_item = TodoItem.find(params[:item])
    @user = @todo_item.user
    @todo_item.destroy
    redirect "/#{@user.id}"
end






#post '/' do  
#    TodoItem.create(description: params[:thing], due: params[:date])
#    redirect '/todo'   
#end

#get '/todo' do
#    @things = TodoItem.all.order(:due) # @things is an instance variable
#    erb :todo
#end

#get '/delete/:id' do
#    TodoItem.find(params[:id]).destroy
#    redirect '/todo'
#end


helpers do
    def blank?(x)
    x.nil? || x == ""
    end
end
