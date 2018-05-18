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


  private
  def operation_params
    params.require(:operation).permit(:date, :type, :description, :amount, :category_id)
  end

end