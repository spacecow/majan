class BookingsController < ApplicationController
  def index
    @month = params[:month] ? Date.parse(params[:month]) : Date.today
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
    @date = Date.parse(params[:date])
  end

  def create
    @date = params[:date]
    day = Day.find_or_create_by_date(@date) 
    @booking = day.available_table.bookings.build(params[:booking])
    if @booking.save
      redirect_to day_path(@date)
    else
      render :new
    end
  end
end
