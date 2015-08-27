class Categories < ActiveRecord::Migration
  def change
    create_table(:categories) do |c|
      c.column(:tags, :string)
    end
  end
end
