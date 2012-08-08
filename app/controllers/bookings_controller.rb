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
      redirect_to detail_bookings_path(date:@date)
    else
      flash[:alert] = 'No table is available.' if @booking.errors[:start_at].empty? and @booking.errors[:end_at].empty?
      render :new
    end
  end

  def detail
    @date = Date.parse(params[:date])
    bookings = Booking.find_all_by_date(@date) || []
    @hash = bookings.group_by{|e| e.majan_table.no}
  end
end
