class CategoriesController < ApplicationController
  before_action :load_category
  authorize_resource

  def show
    @tours = @category.tours.paginate page: params[:page], per_page: Settings.tour.per_page
  end

  private

  def load_category
    @category = Category.available.find_by id: params[:id]
    return if @category
    redirect_to root_url, alert: t(".error_noti")
  end
end
