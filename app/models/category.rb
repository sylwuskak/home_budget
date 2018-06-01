class Category < ActiveRecord::Base
  belongs_to :user

  has_many :operations, dependent: :destroy
  has_many :budgets, dependent: :destroy
end