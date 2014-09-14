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
  counter = 0
  @result = 0
  while counter < Operator.all.length
    @result += Operator.order("id DESC").offset(counter).limit(1).first.value
    counter += 1
  end
  @result
  Operator.delete_all(category: "value")
  erb :index
end

post '/:number' do
  @numbers = Number.create(number: params[:number], category: "number")
  @numbers.save
  erb :index
end


