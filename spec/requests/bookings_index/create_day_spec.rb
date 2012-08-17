require 'spec_helper'

describe "Day create" do
  before(:each) do
    login_admin
  end

  context "disable a day" do
    before(:each) do
      visit bookings_path(month:'2012/7')
    end

    it "saves a day in db" do
      lambda{ td(:day_0714).click_link('Disable')
      }.should change(Day,:count).by(1)
    end

    context "redirects to the right month" do
      it "outside the month" do
        td(:day_0801).click_link('Disable')
      end

      it "inside the month" do
        td(:day_0714).click_link('Disable')
      end
    
      after(:each) do
        page.should have_content('July')
      end
    end
  end

  context "enable a day" do
    before(:each) do
      FactoryGirl.create(:day, date:Date.parse('2012-7-15'))
      FactoryGirl.create(:day, date:Date.parse('2012-8-1'))
      visit bookings_path(month:'2012/7')
    end

    it "deletes a day in db" do
      lambda{ td(:day_0715).click_link('Enable')
      }.should change(Day,:count).by(-1)
    end

    context "redirects to the right month" do
      it "inside the month" do
        td(:day_0715).click_link('Enable')
      end

      it "outside the month" do
        td(:day_0801).click_link('Enable')
      end

      after(:each) do
        page.should have_content('July')
      end
    end
  end
end
