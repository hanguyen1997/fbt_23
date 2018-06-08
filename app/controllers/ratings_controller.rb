class RatingsController < ApplicationController
  before_action :load_rating, only: :update
  before_action :load_tour

  def create
    @rating = Rating.new rating_params
    @tour.update_rating_average if @rating.save
    respond_to do |format|
      format.js{render "load_rating"}
    end
  end

  def update
    @tour.update_rating_average if @rating.update_attributes rating_params
    respond_to do |format|
      format.js{render "load_rating"}
    end
  end

  private

  def load_rating
    @rating = Rating.find_by id: params[:id]
    return if @rating
    flash[:danger] = t "alert.rating_not_found"
    redirect_to root_url
  end

  def load_tour
    @tour = Tour.find_by id: params[:rating][:tour_id]
    return if @tour
    flash[:danger] = t "alert.tour_not_found"
    redirect_to root_url
  end

  def rating_params
    params.require(:rating).permit :point, :tour_id, :user_id
  end
end
