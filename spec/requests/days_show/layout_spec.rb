require 'spec_helper'

describe "Day show" do
  before(:each) do
    @day = FactoryGirl.create(:day, date:'2012-7-2')
  end

  context "without bookings" do
    before(:each) do
      visit day_path(@day)
    end

    it "has a date title" do
      page.should have_title('2012-07-02')
    end

    it "has a schedule" do
      page.should have_div(:schedule)
    end
    it "has a total of eight tables" do
      div(:tables).divs_no(:table).should be(8)
    end

    it "has a reservation button" do
      page.should have_button('Reserve')
      click_button 'Reserve'
      page.current_path.should eq new_booking_path
      value('Date').should eq '2012-07-02'
    end
  end

  #context "with booking on right day" do
  #  before(:each) do
  #    FactoryGirl.create(:booking, reserved_on:Date.parse('2012-7-2'))
  #    visit day_path(@day)
  #  end

  #  it "one class for each booking" do
  #    div(:bookings).divs_no(:booking).should be(1)
  #  end
  #end

  #context "with booking on wrong day" do
  #  before(:each) do
  #    FactoryGirl.create(:booking, reserved_on:Date.parse('2012-7-3'))
  #    visit day_path(@day)
  #  end

  #  it "shows no bookings" do
  #    div(:bookings).divs_no(:booking).should be(0)
  #  end
  #end
end
