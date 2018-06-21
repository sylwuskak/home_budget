class Operation < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :date, presence: true
  validates :amount, presence: true

  def start_time
    self.date 
  end
end