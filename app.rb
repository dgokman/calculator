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
    @number = numbers.join.to_i
  end
  @operators = Operator.create(value: @number, category: "plus")
  @operators.save
  Number.delete_all(category: "number")
  erb :index
end

post '/minus' do
  numbers = []
  Number.all.each do |number|
    numbers << number.number
    @number = numbers.join.to_i
  end
  @operators = Operator.create(value: @number, category: "minus")
  @operators.save
  Number.delete_all(category: "number")
  erb :index
end

post '/times' do
  numbers = []
  Number.all.each do |number|
    numbers << number.number
    @number = numbers.join.to_i
  end
  @operators = Operator.create(value: @number, category: "times")
  @operators.save
  Number.delete_all(category: "number")
  erb :index
end

post '/divide' do
  numbers = []
  Number.all.each do |number|
    numbers << number.number
    @number = numbers.join.to_i
  end
  @operators = Operator.create(value: @number, category: "divide")
  @operators.save
  Number.delete_all(category: "number")
  erb :index
end

post '/equal' do
  numbers = []
  Number.all.each do |number|
    numbers << number.number
    @equal = numbers.join.to_i
  end
  @operators = Operator.create(value: @equal, category: "value")
  @operators.save
  Number.delete_all(category: "number")
  if Operator.all.first.category == "plus"
    @result = Operator.first.value
    counter = 1
    while counter < Operator.all.length
     @result += Operator.offset(counter).limit(1).first.value
     counter += 1
    end
  elsif Operator.all.first.category == "minus"
    @result = Operator.first.value
    counter = 1
    while counter < Operator.all.length
     @result -= Operator.offset(counter).limit(1).first.value
     counter += 1
    end
  elsif Operator.all.first.category == "times"
    @result = Operator.first.value
    counter = 1
    while counter < Operator.all.length
     @result *= Operator.offset(counter).limit(1).first.value
     counter += 1
    end
  else
    @result = Operator.first.value
    counter = 1
    while counter < Operator.all.length
     @result /= Operator.offset(counter).limit(1).first.value
     counter += 1
    end
  end
  Operator.destroy_all
  erb :index
end

post '/:number' do
  @numbers = Number.create(number: params[:number], category: "number")
  @numbers.save
  erb :index
end


