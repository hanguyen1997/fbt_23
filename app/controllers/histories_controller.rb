class HistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.created_at_sort
      .paginate page: params[:page], per_page: Settings.booking.per_page
  end
end
