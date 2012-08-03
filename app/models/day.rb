class Day < ActiveRecord::Base
  has_many :tables

  attr_accessible :date

  before_create :generate_tables

  def available_table; tables.first end
  def to_param; date end

  private

    def generate_tables
      8.times do |i|
        tables.build(no:i+1)
      end
    end
end
