require 'spec_helper'

describe Booking do
  context "collision" do
    before(:each) do
      FactoryGirl.create(:booking, start_at:Time.parse('12:00'), end_at:Time.parse('14:00'))
      @booking = Booking.first
    end

    context "none if" do
      it "before booking" do
        @booking.collision?(Time.parse('11:00'), Time.parse('12:00')).should be_false
      end
      it "after booking" do
        @booking.collision?(Time.parse('14:00'), Time.parse('15:00')).should be_false
      end
    end

    context "if" do
      it "start collision" do
        @booking.collision?(Time.parse('11:00'), Time.parse('12:01')).should be_true
      end
      it "start&end collision" do
        @booking.collision?(Time.parse('11:00'), Time.parse('14:01')).should be_true
      end
      it "end collision" do
        @booking.collision?(Time.parse('13:00'), Time.parse('14:01')).should be_true
      end
    end
  end

  context "#start_at" do
    it "one digit" do
      params = {booking:{start_at:'8'}}
      Booking.correct_start_at!(params)
      params[:booking][:start_at].should eq '8:00'
    end
    it "two digits" do
      params = {booking:{start_at:'12'}}
      Booking.correct_start_at!(params)
      params[:booking][:start_at].should eq '12:00'
    end
    it "three digits" do
      params = {booking:{start_at:'800'}}
      Booking.correct_start_at!(params)
      params[:booking][:start_at].should eq '8:00'
    end
    it "four digits" do
      params = {booking:{start_at:'1200'}}
      Booking.correct_start_at!(params)
      params[:booking][:start_at].should eq '12:00'
    end
  end

  context "#end_at" do
    it "one digit" do
      params = {booking:{end_at:'8'}}
      Booking.correct_end_at!(params)
      params[:booking][:end_at].should eq '8:00'
    end
    it "two digits" do
      params = {booking:{end_at:'12'}}
      Booking.correct_end_at!(params)
      params[:booking][:end_at].should eq '12:00'
    end
    it "three digits" do
      params = {booking:{end_at:'800'}}
      Booking.correct_end_at!(params)
      params[:booking][:end_at].should eq '8:00'
    end
    it "four digits" do
      params = {booking:{end_at:'1200'}}
      Booking.correct_end_at!(params)
      params[:booking][:end_at].should eq '12:00'
    end
  end
end
