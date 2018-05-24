class CategoriesController < ApplicationController
  before_action :set_configuration

  def index
    if user_signed_in?
      @categories = current_user.categories
    end
  end

  def create
    c = Category.new(category_params)
    c.user = current_user
    c.save!

    redirect_to categories_path
  end

  def destroy
    Category.destroy(params[:id])
    redirect_to categories_path
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_edit_params)

    redirect_to categories_path
  end

  def update_configuration
    @configuration.update(configuration_params)    

    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:category_name, :category_type, :keyword)
  end

  def category_edit_params
    params.require(:category).permit(:category_name, :keyword)
  end

  def configuration_params
    params.require(:configuration).permit(:keyword)
  end

  def set_configuration
    if user_signed_in?
      @configuration = current_user.configurations.first
    end
  end

end

