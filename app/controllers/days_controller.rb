class DaysController < ApplicationController
  load_and_authorize_resource

  def create
    if @day.save
      redirect_to bookings_path(month:@day.date.strftime("%Y/%m"))
    end
  end

  def destroy
    month = @day.date.strftime("%Y/%m")
    @day.destroy
    redirect_to bookings_path(month:month)
  end
end
