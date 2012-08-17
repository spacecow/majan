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
      day = FactoryGirl.create(:day,date:Date.parse('2012-7-30'))
      Day.calendar_days_in_month('2012-8').should eq [day]
    end

    it "returns no days before that month" do
      FactoryGirl.create(:day,date:Date.parse('2012-7-28'))
      Day.calendar_days_in_month('2012-8').should be_empty
    end

    it "returns no days after that month" do
      FactoryGirl.create(:day,date:Date.parse('2012-9-2'))
      Day.calendar_days_in_month('2012-8').should be_empty
    end
  end
end
