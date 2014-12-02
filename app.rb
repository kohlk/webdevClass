require 'rubygems'
require 'bundler/setup'

Bundler.require

require './models/Image'
require './models/User'

imgurClient = Imgur.new '5acc7208e8fa6fb' # my dev API key

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
    @imageys = @user.images.order(:due)
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
    User.find(params[:user]).images.create(description: params[:imagey], due: params[:date])
        redirect "/#{params[:user]}"
end

get '/delete_item/:item' do
    @image_thing = Image.find(params[:item])
    @user = @image_thing.user
    @image_thing.destroy
    redirect "/#{@user.id}"
end

helpers do
    def blank?(x)
    x.nil? || x == ""
    end
end

#todo_item is image_thing
#task is imagey
#tasks is imageys
#TodoItem is Images
