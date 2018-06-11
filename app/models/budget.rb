class Budget < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :category_id, uniqueness: { scope: :date }
end