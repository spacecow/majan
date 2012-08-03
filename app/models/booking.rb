class Booking < ActiveRecord::Base
  belongs_to :table

  attr_accessible :reserved_on, :start_at, :end_at

  validates_presence_of :start_at, :end_at

  def date; table.date end
end
