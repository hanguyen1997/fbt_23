class CategoriesController < ApplicationController
  before_action :load_category

  def show
    @tours = @category.tours.paginate page: params[:page], per_page: Settings.tour.per_page
  end

  private

  def load_category
    @category = Category.available.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".error_noti"
    redirect_to root_url
  end
end
