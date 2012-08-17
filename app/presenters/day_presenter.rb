class DayPresenter < BasePresenter
  def booking_count(bookings)
    h.content_tag(:div, :class => 'bookings') do
      if bookings.present?
        "#{h.pl(:booking,bookings.count)}: #{bookings.count}"
      end
    end
  end

  def booking_link(date,month)
    if Day.exists?(date:date)
      date.day 
    else
      h.link_to date.day, h.detail_bookings_path(date:date.strftime("%Y-%m-%d"), month:month.strftime("%Y/%m")), :class => :date
    end
  end

  def toggle_availability(date,month)
    h.content_tag(:div, :class => :availability) do
      if Day.exists?(date:date)
        h.link_to h.t(:enable), h.day_path(Day.find_by_date(date), month:month), :method => :delete, :class => :enable if h.can? :create, Day
      else
        h.link_to h.t(:disable), h.days_path(day:{date:date}, month:month), :method => :post, :class => :disable if h.can? :create, Day
      end
    end
  end
end
