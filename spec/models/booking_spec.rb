require 'spec_helper'

describe Booking do
  before(:each) do
    FactoryGirl.create(:booking, start_at:Time.parse('12:00'), end_at:Time.parse('14:00'))
    @booking = Booking.first
  end

  context "no collision if" do
    it "before booking" do
      @booking.collision?({start_at:'11:00', end_at:'12:00'}).should be_false
    end
    it "after booking" do
      @booking.collision?({start_at:'14:00', end_at:'15:00'}).should be_false
    end
  end

  context "collision if" do
    it "start collision" do
      @booking.collision?({start_at:'11:00', end_at:'12:01'}).should be_true
    end
    it "start&end collision" do
      @booking.collision?({start_at:'11:00', end_at:'14:01'}).should be_true
    end
    it "end collision" do
      @booking.collision?({start_at:'13:00', end_at:'14:01'}).should be_true
    end
  end
end
