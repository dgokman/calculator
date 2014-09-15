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
  Number.create(number: "", category: "number")
  erb :index
end

post '/clear' do
  Number.delete_all(category: "number")
  Operator.destroy_all
  erb :index
end

post '/plus' do
  numbers = []
  Number.all.each do |number|
    numbers << number.number
    @number = numbers.join.to_f
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
    @number = numbers.join.to_f
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
    @number = numbers.join.to_f
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
    @number = numbers.join.to_f
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
    @equal = numbers.join.to_f
  end
  @operators = Operator.create(value: @equal, category: "value")
  @operators.save
  Number.delete_all(category: "number")
  counter = 0
  @result = Operator.first.value
  while counter < (Operator.all.length - 1)
    if Operator.offset(counter).limit(1).first.category == "plus"
     @result += Operator.offset(counter + 1).limit(1).first.value.to_f
     counter += 1
    elsif Operator.offset(counter).limit(1).first.category == "minus"
     @result -= Operator.offset(counter + 1).limit(1).first.value.to_f
     counter += 1
    elsif Operator.offset(counter).limit(1).first.category == "times"
     @result *= Operator.offset(counter + 1).limit(1).first.value.to_f
     counter += 1
    else
     @result /= Operator.offset(counter + 1).limit(1).first.value.to_f
     counter += 1
    end
  end
  @result_display = @result
  Operator.destroy_all
  results = @result.to_s.split("")
  results.each do |result|
    numbers = Number.create(number: result, category: "number")
    numbers.save
  end
  erb :index
end

post '/:number' do
  if params[:number] == "decimal"
    numbers = Number.create(number: ".", category: "number")
  else
    numbers = Number.create(number: params[:number], category: "number")
  end
  numbers.save
  erb :index
end


