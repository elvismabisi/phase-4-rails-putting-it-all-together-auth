class CreateAddUserIdToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :user_id, :integer
    add_index :recipes, :user_id
  end
end
