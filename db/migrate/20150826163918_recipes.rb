class Recipes < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:rating, :integer)
      t.column(:tag, :string)
      t.column(:name, :string)
      t.column(:instructions, :string)

      t.timestamps()
    end
  end
end
