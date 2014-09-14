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

post '/plus' do
  numbers = []
  Number.all.each do |number|
    numbers << number.number
    @plus = numbers.join.to_i
  end
  @plus
  @operators = Operator.create(value: @plus, category: "value")
  @operators.save
  Number.delete_all(category: "number")
  erb :index
end

post '/equal' do
  @result = Operator.first.value + Operator.second.value
  erb :index
end

post '/:number' do
  @numbers = Number.create(number: params[:number], category: "number")
  @numbers.save
  erb :index
end


