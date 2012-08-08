require 'spec_helper'

describe "Bookings detail" do
  context "without bookings" do
    before(:each) do
      FactoryGirl.create(:majan_table)
      visit detail_bookings_path(date:'2012-7-2')
    end

    it "has a date title" do
      page.should have_title('2012-07-02')
    end

    it "has a schedule" do
      page.should have_div(:schedule)
    end
    it "has tables" do
      div(:tables).divs_no(:table).should be(1)
    end

    it "has a reservation button" do
      page.should have_button('Reserve')
      click_button 'Reserve'
      page.current_path.should eq new_booking_path
      value('Date').should eq '2012-07-02'
    end
  end

  context "with booking on right day" do
    before(:each) do
      table = FactoryGirl.create(:majan_table)
      FactoryGirl.create(:booking, date:Date.parse('2012-7-2'), majan_table:table, start_at:Time.parse("12:00"), end_at:Time.parse("14:15"), name:'Ben Dover')
      visit detail_bookings_path(date:'2012-7-2')
    end

    it "one class for each booking" do
      div(:bookings).divs_no(:booking).should be(1)
    end
    it "the booking should have a tooltip" do
      div(:booking,0).span(:tooltip).should have_content('12:00~14:15 Ben Dover')
    end
  end

  context "with booking on wrong day" do
    before(:each) do
      table = FactoryGirl.create(:majan_table)
      FactoryGirl.create(:booking, date:Date.parse('2012-7-3'))
      visit detail_bookings_path(date:'2012-7-2')
    end

    it "shows no bookings" do
      div(:bookings).divs_no(:booking).should be(0)
    end
  end
end
