class SubCategory < ActiveRecord::Base
    belongs_to :category
  
    has_many :operations, dependent: :destroy
end