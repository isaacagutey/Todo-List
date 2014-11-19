require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'sinatra/reloader'

DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/todo.db")
class Todo
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required =>true
  property :done, Boolean, :required =>true, :default =>false
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

set :port,7000

get '/' do
  @todos=Todo.all :order => :id.desc
  @title = 'All Notes'
  # redirect '/new'
  erb :index
end

post '/' do
  object=Todo.new
  object.content=params[:content]
  object.created_at=Time.now
  object.updated_at=Time.now
  object.save
  redirect '/'
end

get '/:id' do
  @todo=Todo.get params[:id]
  @title="Edit todo ##{params[:id]}"
  erb :edit
end

put '/:id' do
  n = Todo.get params[:id]
  n.content = params[:content]
  n.done = params[:done] ? 1 : 0
  n.updated_at = Time.now
  n.save
  redirect '/'
end

get '/:id/delete' do
  @todo=Todo.get params[:id]
  @title="Confirm deletion of todo ##{params[:id]}"
  erb :delete
end

delete '/:id' do
  n= Todo.get params[:id]
  n.destroy
  redirect '/'
end