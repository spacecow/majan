require 'spec_helper'

describe "Bookings new" do
  before(:each) do
    visit new_booking_path(date:'2012-7-2')
  end

  it "has a new booking title" do
    page.should have_title('New Booking')
  end

  it "has the date field filled in" do
    value('* Date').should eq '2012-07-02'
  end

  it "has the start time left blank" do
    value('* Start at').should be_nil 
  end
  it "has the end time left blank" do
    value('* End at').should be_nil 
  end

  it "has the name field blank" do
    value('* Name').should be_nil
  end

  it "has a create button" do
    page.should have_button('Book')
  end
  it "has a cancel button" do
    page.should have_button('Cancel')
  end
end
