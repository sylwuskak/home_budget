class AddTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :category_type, :string
    change_column :categories, :category_type, :string, :null => false
  end
end
