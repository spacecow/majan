require 'spec_helper'

describe "Bookings new" do
  before(:each) do
    visit new_booking_path(date:'2012-7-2')
    fill_in '* Start at', with:'12:10'
    fill_in '* End at', with:'14:15'
    fill_in 'Name', with:'Ben Dover'
  end

  context "fail with" do
    context "no table" do
      it "tables are already saved" do
        lambda{ click_button 'Book'
        }.should change(MajanTable,:count).by(0)
        MajanTable.count.should be 0
      end
      it "saves no booking to db" do
        lambda{ click_button 'Book'
        }.should change(Booking,:count).by(0)
        Booking.count.should be 0
      end
      it "displays flash" do
        click_button 'Book'
        page.should_not have_alert('No table is available.') 
      end
    end

    context "fully booked table" do
      before(:each) do 
        table = FactoryGirl.create(:majan_table)
        FactoryGirl.create(:booking, majan_table:table, date:Date.parse('2012-7-2'), start_at:Time.parse('13:00'), end_at:Time.parse('15:00'))
      end

      it "saves no tables to db" do
        lambda{ click_button 'Book'
        }.should change(MajanTable,:count).by(0)
        MajanTable.count.should be 1
      end
      it "saves no booking to db" do
        lambda{ click_button 'Book'
        }.should change(Booking,:count).by(0)
        Booking.count.should be 1
      end
      it "displays flash" do
        click_button 'Book'
        page.should have_alert('No table is available for that time interval.') 
      end
    end
  end

  it "create without existing day"

  context "create with unused table" do
    before(:each) do 
      table = FactoryGirl.create(:majan_table)
      FactoryGirl.create(:booking, majan_table:table, date:Date.parse('2012-7-2'), start_at:Time.parse('8:00'), end_at:Time.parse('10:00'))
    end

    it "saves the tables to db" do
      lambda{ click_button 'Book'
      }.should change(MajanTable,:count).by(0)
      MajanTable.count.should be 1
    end
    it "saves a booking to db" do
      lambda{ click_button 'Book'
      }.should change(Booking,:count).by(1)
      Booking.count.should be 2
    end

    context "saves" do
      before(:each) do 
        click_button 'Book'
        @booking = Booking.last
      end

      it "the date" do
        @booking.date.should eq Date.parse('2012-7-2')
      end
      it "a table reference" do
        @booking.majan_table.should eq MajanTable.last 
      end

      it "the start time" do
        @booking.start_at.strftime("%H:%M").should eq "12:10"
      end
      it "the end time" do
        @booking.end_at.strftime("%H:%M").should eq "14:15"
      end
      it "the name of the player" do
        @booking.name.should eq "Ben Dover"
      end

      it "and redirect back to the day page" do
        page.current_path.should eq detail_bookings_path
        page.should have_title('2012-07-02')
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
        page.current_path.should eq detail_bookings_path
        page.should have_title('2012-07-02')
      end
    end

    context "from the error page" do
      before(:each) do
        fill_in 'Start at', with:''
        click_button 'Book'
        click_button 'Cancel'
      end

      it "redirect back to the detail page" do
        page.current_path.should eq detail_bookings_path
        page.should have_title('2012-07-02')
      end
    end
  end

  context "error with pre-existing booking" do
    before(:each) do
      FactoryGirl.create(:booking, date:Date.parse('2012-7-2'))
    end

    it "start at cannot be left blank" do
      fill_in 'Start at', with:''
      click_button 'Book'
      div(:start_at).should have_blank_error
    end
    it "start has to be >= 8am" do
      fill_in 'Start at', with:'7:00'
      click_button 'Book'
      div(:start_at).should have_error "must be greater than or equal to  8:00"
    end
    it "start has to be <= 18am" do
      fill_in 'Start at', with:'19:00'
      click_button 'Book'
      div(:start_at).should have_error "must be less than or equal to 18:00"
    end

    it "end at cannot be left blank" do
      fill_in 'End at', with:''
      click_button 'Book'
      div(:end_at).should have_blank_error
    end
    it "end has to be >= 8am" do
      fill_in 'End at', with:'7:00'
      click_button 'Book'
      div(:end_at).should have_error "must be greater than or equal to  8:00"
    end
    it "end has to be <= 18am" do
      fill_in 'End at', with:'19:00'
      click_button 'Book'
      div(:end_at).should have_error "must be less than or equal to 18:00"
    end

    it "displays no flash" do
      fill_in 'Start at', with:''
      click_button 'Book'
      page.should_not have_alert('No table is available for that time interval.') 
    end
  end
end
