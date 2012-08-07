class DayPresenter < BasePresenter
  TABLE_BASE_HEIGHT = 20
  TABLE_INC_HEIGHT = 10
  BASE_TIME = Time.zone.parse('8:000')
  UNIT_WIDTH = 50 

  def table_style(bookings)
    bookings_count = bookings.nil? ? 0 : bookings.count 
    "style='#{height('height', bookings_count)}; #{height('line-height', bookings_count)};'"
  end

  def booking_style(table_no, i, booking)
    return if table_no.nil?
    "style='#{top(table_no)}; #{left(booking)}; #{width(booking)};'"
  end

  private

    def height(s, booking_count)
      "#{s}: #{TABLE_BASE_HEIGHT + (booking_count >= 1 ? (booking_count-1)*TABLE_INC_HEIGHT : 0)}px;"
    end
    def measure(s,unit,i,base=0)
      "#{s}: #{unit*i+base}px"
    end
    def minutes(time) time.hour*60+time.min end
    def left(booking)
      units = units(booking.start_at,BASE_TIME)
      measure("left", UNIT_WIDTH, units, 1)
    end
    def top(table_no) 
      "top: #{10*table_no+5}px"
    end
    def units(stop,start)
      (minutes(stop)-minutes(start))/60.0
    end
    def width(booking)
      units = units(booking.end_at, booking.start_at) 
      measure("width", UNIT_WIDTH, units)
    end
end
