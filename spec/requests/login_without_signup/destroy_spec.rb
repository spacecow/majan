require 'spec_helper'

describe 'Sessions destroy', focus:true do
  context "logout" do
    before(:each) do
      login
    end

    it "redirects to the root page" do
      current_path.should eq root_path
    end

    it "shows a logged-out flash message" do
    end
    
    #current_path.should eq user_path(member)
  end
end
