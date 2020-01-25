class OperationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @operations = nil

    if params[:search_phrase].nil? 
      @operations = current_user.operations.order(date: :desc, created_at: :desc).paginate(:page => params[:page], :per_page => 10)
    else
      search = params[:search_phrase]
      @operations = current_user.operations.where("description LIKE ? or amount = ? ", '%' + params[:search_phrase] + '%', params[:search_phrase].to_f).order(date: :desc).paginate(:page => params[:page], :per_page => 10)
    end
  end
    
  def create
    begin
      o = Operation.new(operation_params)
      o.user = current_user
      o.type = params['type']
      o.save!
    rescue => e
      flash[:danger] = I18n.t('operations.save_failure')
    end

    redirect_to operations_path(page: params['page'].empty? ? 1 : params['page'])
  end

  def destroy
    Operation.destroy(params[:id])
    redirect_to operations_path
  end

  def update
    begin    
      @operation = Operation.find(params[:id])
      @operation.update!(operation_edit_params)
    rescue => e
      flash[:danger] = I18n.t('operations.save_failure')
    end
    redirect_to operations_path(page: params['page'].empty? ? 1 : params['page'])
    
  end

  private
  def operation_params
    permit_params = params.require(:operation).permit(:date, :type, :description, :amount, :category_id, :expense_type)
    permit_params['amount'] = permit_params['amount'].gsub(',', '.').to_f.round(2).to_s
    permit_params
  end

  def operation_edit_params
    if @operation.is_a? Expense
      permit_params = params.require(:expense).permit(:date, :description, :amount, :category_id, :expense_type)  
    elsif @operation.is_a? Incoming
      permit_params = params.require(:incoming).permit(:date, :description, :amount, :category_id)  
    end

    permit_params['amount'] = permit_params['amount'].gsub(',', '.').to_f.round(2).to_s
    permit_params
  end

end