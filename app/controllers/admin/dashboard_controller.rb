module Admin
  class DashboardController < BaseController
    def index
      @recent_bookings = Booking.pending
        .created_at_sort.limit(Settings.booking.limit)
        .paginate page: params[:page], per_page: Settings.booking.per_page
    end
  end
end
