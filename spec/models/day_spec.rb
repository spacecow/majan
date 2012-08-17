require 'spec_helper'

describe Day do
  it "date has to exist" do
    lambda { Day.create(date:'')
    }.should change(Day,:count).by(0)
  end

  it "date cannot be doubled" do
    date = Date.parse('2012-7-18')
    FactoryGirl.create(:day,date:date)
    lambda { Day.create(date:date)
    }.should change(Day,:count).by(0)
  end

  describe "#days_in_month" do
    it "returns the days in that month" do
      d0816 = FactoryGirl.create(:day,date:Date.parse('2012-8-16'))
      Day.days_in_month('2012-8').should eq [d0816]
    end

    it "returns no days before that month" do
      d0731 = FactoryGirl.create(:day,date:Date.parse('2012-7-31'))
      Day.days_in_month('2012-8').should be_empty
    end

    it "returns no days after that month" do
      d0931 = FactoryGirl.create(:day,date:Date.parse('2012-9-30'))
      Day.days_in_month('2012-8').should be_empty
    end
  end
end
