class RemoveTagsFromRecipes < ActiveRecord::Migration
  def change
    remove_column(:recipes, :tag)
  end
end
