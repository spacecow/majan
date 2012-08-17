class Day < ActiveRecord::Base
  attr_accessible :date
  
  validates :date, presence:true, uniqueness:true

  class << self
    def calendar_days_in_month(month)
      first_day = Date.parse("#{month}-1").beginning_of_month
      first_day -= 1.day until first_day.sunday?
      last_day = Date.parse("#{month}-1").end_of_month 
      last_day += 1.day until last_day.saturday?
      Day.where('date >= ? and date <= ?', first_day, last_day)
    end
  end
end
