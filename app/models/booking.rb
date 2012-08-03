class Booking < ActiveRecord::Base
  belongs_to :table

  attr_accessible :start_at, :end_at

  validates_presence_of :start_at, :end_at

  def date; table.date end

  class << self
    def style(i,booking) "style='#{top(i)}; #{left(booking)}'" end
    def top(i); "top: #{i*20}px" end
    def left(booking)
      base = Time.parse('2000-01-01').utc + 8.hours
      units = (booking.start_at - base)/60/15
      "left: #{3*units}px"
    end
  end
end
