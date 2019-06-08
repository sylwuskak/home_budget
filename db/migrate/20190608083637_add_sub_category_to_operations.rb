class AddSubCategoryToOperations < ActiveRecord::Migration[5.0]
  def change
    add_reference :operations, :sub_category, foreign_key: true
  end
end
