class CategoriesController < ApplicationController
  
  def index
    @categories = current_user.categories
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


  private
  def category_params
    params.require(:category).permit(:category_name)
  end

end

