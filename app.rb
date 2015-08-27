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
  @recipes = Recipe.all()
  erb(:recipes)
end

post '/recipes' do
    name = params.fetch('recipe')
    @recipes = Recipe.create({:name => name})
    @recipes = Recipe.all
    erb :recipes
end

post '/recipes/:id' do
  id = params.fetch('id').to_i
  ingredient = params.fetch('ingredient')
  @recipes = Recipe.find(id)
  @ingredient = @recipes.ingredients
  ingredient = Ingredient.create({name: ingredient, recipe_id: @recipes.id})
  erb(:recipe_detail)
end

get '/recipes/new' do
  erb(:recipe_add)
end

get '/recipes/:id' do
  id = params.fetch('id').to_i
  @recipe = Recipe.find(id)
  @ingredient = @recipe.ingredients
  erb :recipe_detail
end

delete '/recipes/:id' do
  id = params.fetch('id')
  @recipes = Recipe.find(id)
  ingredients = @recipes.ingredients
  ingredients.destroy
  @ingredient = Ingredient.all
  @recipe = Recipe.all
  erb(:recipe_detail)
end

####ingredients#####

delete '/ingredients/:id/delete' do
  @ingredient = Ingredient.find(params.fetch('ingredient_id').to_i)
  recipe = @ingredient.recipe_id
  @ingredient.destroy
  redirect "/recipes/#{recipe}"
end


delete '/recipes/:id/delete' do
  @recipe = Recipe.find(params.fetch('id').to_i)
  @recipe.destroy
  @recipes = Recipe.all
  erb :recipes
end


#instruction###
patch '/recipes/:id/update' do
  id = params.fetch("id")
  instructions = params.fetch('instructions')
  @recipe = Recipe.find(params.fetch('id').to_i)
  @recipe.update({instructions: instructions})
  binding.pry
  redirect "/recipes/#{@recipe.id}"
end
