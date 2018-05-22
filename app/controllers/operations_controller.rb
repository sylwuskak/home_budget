class OperationsController < ApplicationController
  
  def index
    if user_signed_in?
      @operations = current_user.operations.order(date: :desc)
    end
  end
    
  def create
    o = Operation.new(operation_params)
    o.user = current_user
    o.save!

    redirect_to operations_path
  end

  def destroy
    Operation.destroy(params[:id])
    redirect_to operations_path
  end

  def update
    @operation = Operation.find(params[:id])
    @operation.update(operation_edit_params)

    redirect_to operations_path
  end

  private
  def operation_params
    params.require(:operation).permit(:date, :type, :description, :amount, :category_id)
  end

  def operation_edit_params
    if @operation.is_a? Expense
      params.require(:expense).permit(:date, :description, :amount, :category_id)  
    elsif @operation.is_a? Incoming
      params.require(:incoming).permit(:date, :description, :amount, :category_id)  
    end
  end

end