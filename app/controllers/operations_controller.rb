class OperationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @operations = current_user.operations.order(date: :desc)
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

  def upload
    begin
      file = params.require(:operations_file)
      Tools::OperationFileImporter.import(file, current_user)
      flash[:success] = I18n.t('operations.upload_file_success')
    rescue => e
      flash[:danger] = I18n.t('operations.upload_file_failure') + ": #{e.message}"
    end
    redirect_to operations_path
  end

  private
  def operation_params
    permit_params = params.require(:operation).permit(:date, :type, :description, :amount, :category_id)
    permit_params['amount'] = permit_params['amount'].gsub(',', '.')
    permit_params
  end

  def operation_edit_params
    if @operation.is_a? Expense
      permit_params = params.require(:expense).permit(:date, :description, :amount, :category_id)  
    elsif @operation.is_a? Incoming
      permit_params = params.require(:incoming).permit(:date, :description, :amount, :category_id)  
    end

    permit_params['amount'] = permit_params['amount'].gsub(',', '.')
    permit_params
  end

end