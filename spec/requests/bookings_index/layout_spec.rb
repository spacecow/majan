require 'spec_helper'

describe "Bookings index" do
  context "not logged in, without bookings" do
    before(:each) do
      FactoryGirl.create(:day,date:Date.parse('2012-7-15'))
      visit bookings_path(month:'2012/7')
    end

    it "has a date title" do
      page.should have_content('July 2012')
    end

    it "has links to detail bookings" do
      div(:calendar).click_link('1')
      page.current_path.should eq detail_bookings_path
      page.should have_title('2012-07-01')
    end

    it "has no links to bookings if day is disabled" do
      td(:day_0715).should_not have_link('15')
    end

    it "non-admin cannot disable days" do
      page.should_not have_link('Disable')
    end
  end

  context "admin" do
    before(:each) do
      login_admin
      FactoryGirl.create(:day,date:Date.parse('2012-7-15'))
      visit bookings_path(month:'2012/7')
    end

    it "enabled day should have disable link" do
      td(:day_0716).should have_link('Disable')
    end
    it "disabled day should have enable link" do
      td(:day_0715).should have_link('Enable')
    end
  end

  context "with booking" do
    before(:each) do
      FactoryGirl.create(:booking, date:Date.parse('2012-7-2'))
    end

    it "single" do
      visit bookings_path(month:'2012/7')
      td(:day_0702).should have_content('Booking: 1')
    end

    it "double" do
      FactoryGirl.create(:booking, date:Date.parse('2012-7-2'))
      visit bookings_path(month:'2012/7')
      td(:day_0702).should have_content('Bookings: 2')
    end
  end
end
