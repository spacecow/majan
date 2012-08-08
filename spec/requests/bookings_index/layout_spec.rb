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
      page.current_path.should eq detail_bookings_path
      page.should have_title('2012-07-01')
    end
  end

  context "with bookings" do
    before(:each) do
      FactoryGirl.create(:booking, date:Date.parse('2012-7-2'))
      visit bookings_path(month:'2012/7')
    end

    it "" do
    end
  end
end
