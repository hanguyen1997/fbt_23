class ReviewsController < ApplicationController
  authorize_resource

  def create
    @review = Review.new review_params
    @review.save
    respond_to :js
  end

  private

  def review_params
    params.require(:review).permit :content, :tour_id, :user_id
  end
end
