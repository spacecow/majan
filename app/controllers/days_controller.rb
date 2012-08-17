class DaysController < ApplicationController
  load_and_authorize_resource
  before_filter :set_month, :only => [:create,:destroy]

  def create
    if @day.save
      redirect_to bookings_path(month:@month.strftime("%Y/%m"))
    end
  end

  def destroy
    @day.destroy
    redirect_to bookings_path(month:@month)
  end

  private

    def set_month
      @month = Date.parse(params[:month])
      assert_not_nil(@month) if $AVLUSA
    end
end
