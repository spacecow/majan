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
    @booking = Booking.book(params[:booking], @date)
    if @booking.save
      redirect_to day_path(@date)
    else
      flash[:alert] = 'No table is available.' if @booking.errors[:start_at].empty? and @booking.errors[:end_at].empty?
      render :new
    end
  end
end
