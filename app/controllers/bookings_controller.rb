class BookingsController < ApplicationController
  def index
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @bookings = Booking.all
  end
end
