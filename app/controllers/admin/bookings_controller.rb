module Admin
  class BookingsController < BaseController
    before_action :load_booking, only: %i(show update)

    def index
      @bookings = Booking.created_at_sort
        .paginate page: params[:page], per_page: Settings.booking.per_page
    end

    def show; end

    def update
      if @booking.update_attributes booking_params
        flash[:success] = t "alert.booking_updated"
        BookingMailer.booking_response(@booking).deliver_now unless @booking.pending?
        redirect_to admin_booking_path @booking
      else
        handle_update_status if booking_params[:status].present?
      end
    end

    private

    def booking_params
      params.require(:booking).permit :status
    end

    def load_booking
      @booking = Booking.find_by id: params[:id]
      return if @booking
      flash[:danger] = t "alert.booking_not_found"
      redirect_to admin_bookings_path
    end

    def handle_update_status
      @booking.errors.messages[:expire].each do |msg|
        flash[:danger] = msg
      end
      redirect_to admin_booking_path @booking
    end
  end
end
