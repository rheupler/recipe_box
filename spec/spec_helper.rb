ENV['RAKE_ENV'] = 'test'
require 'sinatra/activerecord'
require 'rspec'
require 'pg'
require './lib/recipes'
require './lib/ingredients'



require("bundler/setup")
Bundler.require(:default, :test)


require('capybara/rspec')
Capybara.app = Sinatra::Application
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Recipe.all.each do |recipe|
      recipe.destroy
    end
    Ingredient.all.each do |ingredient|
      ingredient.destroy
    end
  end
end
