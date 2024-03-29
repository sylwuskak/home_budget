class BudgetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @budgets_hash = current_user.budgets.group_by{|b| b.date}.sort_by{|k, v| k}.reverse.to_h
    @categories = current_user.categories.order(:category_name).where(category_type: "Expense")
  end

  def budgets_create
    begin
      params_date = params['date'].split('-').map{|a| a.to_i}
      date = Date.new(*params_date)

      params['budgets'].each do |bp|
        b = Budget.new(budget_params(bp))
        b.user = current_user
        b.date = date
        b.save!
      end
    rescue => e
      flash[:danger] = I18n.t('budgets.duplicates_error')
    end
    redirect_to budgets_path
  end

  def budgets_destroy
    current_user.budgets.select{|b| b.date == Date.parse(params["format"])}.map{|b| b.destroy}
    redirect_to budgets_path
  end

  def budgets_update
    params['budgets'].each do |id, bp|
      b = Budget.find(id)
      b.update(budget_params(bp))
    end

    redirect_to budgets_path
  end

  def budgets_copy
    begin
      current_user.budgets.select{|b| b.date == Date.parse(params["format"])}.each do |budget|
        b = Budget.new
        b.amount = budget.amount
        b.category_id = budget.category_id
        b.date = Date.today.beginning_of_month
        b.user = current_user
        b.save!
      end
    rescue => e
      flash[:danger] = I18n.t('budgets.duplicates_error')
    end
    redirect_to budgets_path
  end

  def update
    @budget = Budget.find(params[:id])
    @budget.update(budget_params)

    redirect_to budgets_path
  end

  private
  def budget_params(bp)
    permit_params = bp.permit(:date, :amount, :category_id)
    permit_params['amount'] = permit_params['amount'].gsub(',', '.').to_f.round(2).to_s
    permit_params
  end

end