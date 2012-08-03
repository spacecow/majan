require 'spec_helper'

describe "Bookings new" do
  before(:each) do
    visit new_booking_path(date:'2012-7-2')
    fill_in 'Start at', with:'12:10'
    fill_in 'End at', with:'14:15'
  end

  context "create with existing day" do
    before(:each) do 
      FactoryGirl.create(:day, date:Date.parse('2012-7-2'))
    end

    it "day is already saved" do
      lambda{ click_button 'Book'
      }.should change(Day,:count).by(0)
    end
    it "tables are already saved" do
      lambda{ click_button 'Book'
      }.should change(Table,:count).by(0)
    end
    it "saves a booking to db" do
      lambda{ click_button 'Book'
      }.should change(Booking,:count).by(1)
    end
  end

  context "create without existing day" do
    it "saves the day to db" do
      lambda{ click_button 'Book'
      }.should change(Day,:count).by(1)
    end
    it "saves the tables to db" do
      lambda{ click_button 'Book'
      }.should change(Table,:count).by(8)
      Table.count.should be 8
    end
    it "saves a booking to db" do
      lambda{ click_button 'Book'
      }.should change(Booking,:count).by(1)
    end

    context "saves" do
      before(:each) do 
        click_button 'Book'
        @booking = Booking.last
      end

      it "the date" do
        @booking.date.should eq Date.parse('2012-7-2') 
      end
      it "the start time" do
        @booking.start_at.strftime("%H:%M").should eq "12:10"
      end
      it "the end time" do
        @booking.end_at.strftime("%H:%M").should eq "14:15"
      end

      it "and redirect back to the day page" do
        page.current_path.should eq day_path('2012-07-02')
      end
    end
  end

  context "cancel" do
    context "from the main page" do
      it "saves no booking to db" do
        lambda{ click_button 'Cancel'
        }.should change(Booking,:count).by(0)
      end

      it "redirect back to the detail page" do
        click_button 'Cancel'
        page.current_path.should eq day_path('2012-07-02')
      end
    end

    context "from the error page" do
      before(:each) do
        fill_in 'Start at', with:''
        click_button 'Book'
        click_button 'Cancel'
      end

      it "redirect back to the detail page" do
        page.current_path.should eq day_path('2012-07-02')
      end
    end
  end

  context "error" do
    it "start at cannot be left blank" do
      fill_in 'Start at', with:''
      click_button 'Book'
      div(:start_at).should have_blank_error
    end

    it "end at cannot be left blank" do
      fill_in 'End at', with:''
      click_button 'Book'
      div(:end_at).should have_blank_error
    end
  end
end
