class AddOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :operations do |t|
      t.string :type, null: false
      t.float :amount
      t.text :description
      t.date :date
      
      t.references :category
      t.references :user, null: false
    end 
  end
end
