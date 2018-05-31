class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @budgets = current_user.budgets.order(date: :desc)
    @categories = current_user.categories.order(:category_name)
  end

  def budgets_create
    # require 'pry'
    # binding.pry
    params_date = params['date'].split('-').map{|a| a.to_i}
    date = Date.new(*params_date)

    params['budgets'].each do |bp|
      b = Budget.new(budget_params(bp))
      b.user = current_user
      b.date = date
      b.save!
    end
    redirect_to budgets_path
  end
    
  # def create
  #   o = Budget.new(budget_params)
  #   o.user = current_user
  #   o.save!

  #   redirect_to budgets_path
  # end

  def destroy
    Budget.destroy(params[:id])
    redirect_to budgets_path
  end

  def update
    @budget = Budget.find(params[:id])
    @budget.update(budget_params)

    redirect_to budgets_path
  end

  private
  def budget_params(bp)
    bp.permit(:date, :amount, :category_id)
  end

end