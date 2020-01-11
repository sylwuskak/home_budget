class DeleteKeyword < ActiveRecord::Migration[5.0]
  def change
    remove_column :categories, :keyword 
  end
end
