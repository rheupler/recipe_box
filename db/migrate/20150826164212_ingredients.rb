class Ingredients < ActiveRecord::Migration
  def change
    create_table(:ingredients) do |t|
      t.column(:recipe_id, :integer)
      t.column(:name, :string)

      t.timestamps()
    end
  end
end
