require 'spec_helper'
require 'capybara/rspec'
require './app'

describe '/', type: :feature do
  it 'displays the home page for cookbook' do
    visit '/'
    expect(page).to have_content('Welcome to your CookBook')
  end
end

describe '/', type: :feature do
  it 'goes to recipes page' do
    visit '/'
    click_link 'Browse Recipes'
    expect(page).to have_content('Here are your recipes')
  end
end

describe '/', type: :feature do
  it 'goes to add recipes page' do
    visit '/'
    click_link "Add Recipes"
    expect(page).to have_content('Add a recipe')
  end
end

describe '/recipe/new', type: :feature do
  it 'adds a recipe to database' do
    visit '/'
    click_link 'Add Recipes'
    fill_in('recipe_name', :with =>'California Burrito')
    click_button('Add Recipe')
    expect(page).to have_content('California Burrito')
  end
end
