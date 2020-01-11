class DeleteSubcategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :operations, :sub_category_id 
    drop_table :sub_categories
  end
end
