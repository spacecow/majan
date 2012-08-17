class Day < ActiveRecord::Base
  attr_accessible :date
  
  validates :date, presence:true, uniqueness:true

  class << self
    def days_in_month(month)
      Day.where('date >= ? and date <= ?', Date.parse("#{month}-1").beginning_of_month, Date.parse("#{month}-1").end_of_month) 
    end
  end
end
