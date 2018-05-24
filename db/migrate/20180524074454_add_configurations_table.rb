class AddConfigurationsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :configurations do |t|
      t.text :keyword
      
      t.references :user, null: false
    end 
  end
end
