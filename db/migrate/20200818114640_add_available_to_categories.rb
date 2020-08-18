class AddAvailableToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :available, :boolean, null: false, default: true
  end
end
