require 'spec_helper'

describe "Bookings index" do
  context "without bookings" do
    before(:each) do
      visit bookings_path(month:'2012/7')
    end

    it "has a date title" do
      page.should have_content('July')
    end

    it "has links to detail bookingss" do
      div(:calendar).click_link('1')
      page.current_path.should eq day_path('2012-07-01') 
      page.should have_title('2012-07-01')
    end
  end

  context "with bookings", focus:true do
    before(:each) do
      day = FactoryGirl.create(:day, date:Date.parse('2012-7-2'))
      FactoryGirl.create(:booking, day:day)
      visit bookings_path(month:'2012/7')
    end

    it "" do
    end
  end
end
