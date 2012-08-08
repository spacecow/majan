class BookingsController < ApplicationController
  def index
    @month = params[:month] ? Date.parse(params[:month]) : Date.today
    @bookings = Booking.all
  end

  def new
    @date = Date.parse(params[:date])
    @booking = Booking.new(date:@date)
  end

  def create
    Booking.correct_time!(params)
    @booking = Booking.new(params[:booking])
    if @booking.valid?
      if @booking.book
        @booking.save
        redirect_to detail_bookings_path(date:@booking.date)
      else
        flash[:alert] = alertify(:no_table_available) 
        render :new
      end
    else
      render :new
    end
  end

  def detail
    @date = Date.parse(params[:date])
    bookings = Booking.find_all_by_date(@date) || []
    @hash = bookings.group_by{|e| e.majan_table.no}
  end
end
