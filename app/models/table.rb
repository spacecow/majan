class Table < ActiveRecord::Base
  belongs_to :day
  has_many :bookings

  attr_accessible :day_id, :no

  def date; day.date end
end
