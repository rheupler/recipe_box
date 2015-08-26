require('spec_helper')

describe(Recipe) do
  describe("ingredients") do
    it('shows all ingredients in recipe') do
      test_recipe = Recipe.create({name: "Spinach Craze"})
      test_ingredient1 = Ingredient.create({name: "Spinach", recipe_id: test_recipe.id})
      test_ingredient2 = Ingredient.create({name: "Craze", recipe_id: test_recipe.id})
      expect(test_recipe.ingredients()). to eq([test_ingredient1, test_ingredient2])
    end
  end
end
