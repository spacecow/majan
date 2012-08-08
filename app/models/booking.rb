class Booking < ActiveRecord::Base
  belongs_to :majan_table
  belongs_to :day

  attr_accessible :start_at, :end_at, :day_id, :majan_table_id, :name

  validates_presence_of :start_at, :end_at, :day, :majan_table, :name

  def collision?(params)
    return false if Booking.before(Time.parse(params[:start_at]), start_at) and Booking.before(Time.parse(params[:end_at]), start_at)
    return false if Booking.after(Time.parse(params[:start_at]), end_at) and Booking.after(Time.parse(params[:end_at]), end_at)
    return true
  end

  def info
    "#{start_at.strftime('%k:%M')}~#{end_at.strftime('%k:%M')} #{name}"
  end

  class << self
    def after(t1, t2)
      (t1.hour*60 + t1.min) >= (t2.hour*60 + t2.min)
    end
    def before(t1, t2)
      (t1.hour*60 + t1.min) <= (t2.hour*60 + t2.min)
    end
    def book(params, date)
      day = Day.find_or_create_by_date(date) 
      tables = MajanTable.all
      day.bookings.each do |booking|
        if booking.collision?(params)
          tables.delete(booking.majan_table)
        end
      end
      if tables.empty?
        Booking.new(params)
      else
        Booking.new(params.merge({day_id:day.id, majan_table_id:tables.first.id}))
      end
    end
  end
end
