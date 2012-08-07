class Day < ActiveRecord::Base
  has_many :bookings
  has_many :majan_tables, :through => :bookings

  attr_accessible :date

  def to_param; date end
end
