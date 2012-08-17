class DayPresenter < BasePresenter
  def booking_count(bookings)
    if bookings.present?
      h.content_tag(:div, :class => 'bookings') do
        "#{h.pl(:booking,bookings.count)}: #{bookings.count}"
      end
    end
  end

  def booking_link(date)
    if Day.exists?(date:date)
      date.day 
    else
      h.link_to date.day, h.detail_bookings_path(date:date.strftime("%Y-%m-%d"))
    end
  end

  def toggle_availability(date)
    if Day.exists?(date:date)
      h.link_to h.t(:enable), Day.find_by_date(date), :method => :delete if h.can? :create, Day
    else
      h.link_to h.t(:disable), h.days_path(day:{date:date}), :method => :post if h.can? :create, Day
    end
  end
end
