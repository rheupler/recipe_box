require 'sinatra/activerecord'
require './lib/recipes'
require './lib/ingredients'
require 'sinatra/reloader'
require 'sinatra'
require 'pry'
also_reload('lib/**/*.rb')


get '/' do
  erb :index
end

get '/recipes' do
  @recipes = Recipes.all()
  erb(:recipes)
end
