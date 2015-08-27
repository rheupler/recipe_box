require 'sinatra/activerecord'
require './lib/recipes'
require './lib/ingredients'
require './lib/categories'
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

patch '/recipes/:id/update' do
  id = params.fetch('id')
  @recipe = Recipe.find(id)
  instructions = params.fetch("instructions", @recipe.instructions)
  name = params.fetch("recipe_name", @recipe.name)
  @recipe.update({name: name, instructions: instructions})
  redirect "/recipes/#{@recipe.id}"
end

post '/recipes' do
    name = params.fetch('recipe')
    @recipe = Recipe.create({:name => name})
    @recipes = Recipe.all
    erb :recipes
end

post '/recipes/:id' do
  id = params.fetch('id').to_i
  ingredient = params.fetch('ingredient')
  @recipe = Recipe.find(id)
  @ingredient = @recipe.ingredients
  #need to define @categories for recipe_detail.erb page.
  @categories = Category.all
  ingredient = Ingredient.create({name: ingredient, recipe_id: @recipe.id})
  erb(:recipe_detail)
end

get '/recipes/new' do
  erb(:recipe_add)
end

get '/recipes/:id' do
  id = params.fetch('id').to_i
  @recipe = Recipe.find(id)
  @ingredient = @recipe.ingredients
  @categories = Category.all()
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

####Categories####
post ('/tags_add') do
  tags = params.fetch('category')
  @category = Category.create({tags: tags})
  #see if direct to general page will work, try and fix redirect to specific recipe later
  redirect "/recipes"
end

get ('/tags_add') do
  #how do we get recipe id to tags add page?
  erb(:tags_add)
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
# patch '/recipes/:id/update' do
#   id = params.fetch("id")
#   instructions = params.fetch('instructions')
#   @recipe = Recipe.find(params.fetch('id').to_i)
#   @recipe.update({instructions: instructions})
#   redirect "/recipes/#{@recipe.id}"
# end
