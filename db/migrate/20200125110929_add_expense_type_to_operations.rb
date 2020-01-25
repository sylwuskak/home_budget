class AddExpenseTypeToOperations < ActiveRecord::Migration[5.0]
  def change
    add_column :operations, :expense_type, :string
  end
end
