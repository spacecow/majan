class MajanTable < ActiveRecord::Base
  has_many :bookings

  attr_accessible :day_id, :no

  def date; day.date end
end
