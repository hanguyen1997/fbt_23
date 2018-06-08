class BookingsController < ApplicationController
  before_action :logged_in_user
  before_action :load_description_detail, only: :new

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new booking_params
    if @booking.save
      BookingMailer.booking_success(current_user, @booking).deliver_now
      flash[:success] = t ".successed"
      redirect_to history_url
    else
      flash[:danger] = t ".failed"
      redirect_to new_booking_url id: @booking.description_detail.id
    end
  end

  private

  def booking_params
    params.require(:booking).permit :price, :quantity, :description_detail_id, :user_id
  end

  def load_description_detail
    @description_detail = DescriptionDetail.available.find_by id: params[:id]
    return if @description_detail
    flash[:danger] = t ".danger_mess"
    redirect_to root_url
  end
end
