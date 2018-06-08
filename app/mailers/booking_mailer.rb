class BookingMailer < ApplicationMailer
  def booking_success user, booking
    @user = user
    @booking = booking

    mail to: user.email, subject: t("bookings.create.successed")
  end

  def booking_response booking
    @user = User.find_by id: booking.user_id
    @booking = booking

    mail to: @user.email, subject: t(".#{booking.status}")
  end
end
