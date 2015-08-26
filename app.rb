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

post '/recipes' do
    name = params.fetch('recipe')
    @recipes = Recipe.create({:name => name})
    @recipes = Recipe.all
    erb :recipes
end

# get 'recipes/:id' do
#   id = params.fetch('id').to_i
#   @recipes = Recipe.find(id)
#   erb :recipe_detail
# end

get '/recipes/new' do
  erb(:recipe_add)
end
