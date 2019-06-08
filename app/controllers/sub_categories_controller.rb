class SubCategoriesController < ApplicationController
  def create
    c = SubCategory.new(category_params)
    c.category_id = params['category_id']
    c.save!

    redirect_to categories_path
  end

  def destroy
    SubCategory.destroy(params[:id])
    redirect_to categories_path
  end

  def update
    @subcategory = SubCategory.find(params[:id])
    @subcategory.update(category_params)

    redirect_to categories_path
  end

  private
  def category_params
    params.require(:sub_category).permit(:sub_category_name)
  end

end

