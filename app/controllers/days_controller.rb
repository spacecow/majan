class DaysController < ApplicationController
  def show
    @day = Day.find_or_create_by_date(params[:id]) 
  end
end
