class DaysController < ApplicationController
  def show
    @day = Day.find_or_create_by_date(params[:id]) 
    @hash = @day.bookings.group_by{|e| e.majan_table.no}
  end
end
