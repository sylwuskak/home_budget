class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :categories, dependent: :destroy
  has_many :operations, dependent: :destroy
  has_many :configurations, dependent: :destroy

  after_create :add_default_categories

  def add_default_categories
    I18n.t('user.default_categories.expenses').split(';').each do |expense|
      Category.create!(category_type: 'Expense', category_name: expense, user: self) 
    end

    I18n.t('user.default_categories.incomings').split(';').each do |incoming|
      Category.create!(category_type: 'Incoming', category_name: incoming, user: self)
    end

    Configuration.create!(user: self, keyword: "")
  end
end
