require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'pry'

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
end

get '/' do
  erb :index
end

post '/clear' do
  Number.delete_all(category: "number")
  erb :index
end


post '/:number' do
  @numbers = Number.create(number: params[:number], category: "number")
  @numbers.save
  erb :index
end


