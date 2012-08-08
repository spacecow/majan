require 'spec_helper'

describe BookingPresenter do
  before(:each) do
    @presenter = BookingPresenter.new(Booking.new, nil)
  end

  context "top" do
    it "1st table" do
      @presenter.send('top',0).should eq "top: 5px"
    end
    it "2nd table" do
      @presenter.send('top',1).should eq "top: 15px"
    end
    it "4th table" do
      @presenter.send('top',3).should eq "top: 35px"
    end
  end
end
