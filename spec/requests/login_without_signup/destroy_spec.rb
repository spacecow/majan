require 'spec_helper'

describe 'Sessions destroy', focus:true do
  context "logout" do
    before(:each) do
      login
      user_nav.click_link 'Logout'
    end

    it "redirects to the root page" do
      current_path.should eq root_path
    end

    it "shows a logged-out flash message" do
      page.should have_notice('Logged out')
    end

    it "shows the login link again" do
      user_nav.should have_link 'Login'
    end
    
    #current_path.should eq user_path(member)
  end
end
