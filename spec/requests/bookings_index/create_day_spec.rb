require 'spec_helper'

describe "Day create" do
  before(:each) do
    login_admin
    FactoryGirl.create(:day,date:Date.parse('2012-7-15'))
    visit bookings_path(month:'2012/7')
  end

  context "disable a day" do
    it "saves a day in db" do
      lambda{ td(:day_14).click_link('Disable')
      }.should change(Day,:count).by(1)
    end

    it "redirects to the right month" do
      td(:day_14).click_link('Disable')
      page.should have_content('July')
    end
  end

  context "enable a day" do
    it "deletes a day in db" do
      lambda{ td(:day_15).click_link('Enable')
      }.should change(Day,:count).by(-1)
    end

    it "redirects to the right month" do
      td(:day_15).click_link('Enable')
      page.should have_content('July')
    end
  end
end
