require 'spec_helper'

describe DayPresenter do
  before(:each) do
    view.stub(:can?).and_return true
    @presenter = DayPresenter.new(Day, view)
  end

  #context "toggle_availability" do
  #  it "link to enable if disabled" do
  #    FactoryGirl.create(:day,date:Date.parse('2012-8-16'))
  #    @presenter.toggle_availability('2012-8-16').should eq '<a href="/days" data-method="post" rel="nofollow">Enable</a>'
  #  end

  #  it "link to disable if enabled" do
  #    @presenter.toggle_availability('2012-8-16').should eq '<a href="/days" data-method="post" rel="nofollow">Disable</a>'
  #  end
  #end
end
