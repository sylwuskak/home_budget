class AddBugetsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets do |t|
      t.float :amount
      t.date :date
      
      t.references :category
      t.references :user, null: false
    end 
  end
end
