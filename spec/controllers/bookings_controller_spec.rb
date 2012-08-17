require 'spec_helper'

describe BookingsController do
  controller_actions = controller_actions("bookings")

  before(:each) do
    Booking.stub(:correct_time!).and_return nil
    @model = FactoryGirl.create(:booking)
  end

  describe "a user is not logged in" do
    controller_actions.each do |action,req|
      it "should reach the #{action} page" do
        send("#{req}", "#{action}", :id => @model.id, date:'2012-7-2')
        response.redirect_url.should_not eq login_url 
      end
    end
  end

  it "the detail page cannot be reach if that day is disabled", focus:true do
    date = '2012-7-2'
    FactoryGirl.create(:day,date:Date.parse(date))
    get(:detail, date:date)
    response.redirect_url.should eq bookings_url(month:'2012/07')
  end
end
