class CategoriesController < ApplicationController
  before_action :set_category, except: [:index, :create, :destroy]

  def index
    if user_signed_in?
      @categories = current_user.categories.order(:category_type, :category_name)
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
    @category.update(category_edit_params)

    redirect_to categories_path
  end

  def set_available
    @category.available = true
    @category.save!

    redirect_to categories_path
  end

  def set_unavailable
    @category.available = false
    @category.save!

    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:category_name, :category_type)
  end

  def category_edit_params
    params.require(:category).permit(:category_name)
  end

  def set_category
    @category = Category.find(params[:id] || params[:category_id])
  end

end

