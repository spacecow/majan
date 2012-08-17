require 'spec_helper'

describe DaysController do
  controller_actions = controller_actions("days")

  before(:each) do
    @model = FactoryGirl.create(:day)
  end

  describe "a user is not logged in" do
    controller_actions.each do |action,req|
      it "should not reach the #{action} page" do
        send("#{req}", "#{action}", :id => @model.id)
        response.redirect_url.should eq login_url 
      end
    end
  end

  describe "a user is logged in as" do
    context "admin" do
      before(:each) do
        session[:userid] = create_admin.id
      end
      controller_actions.each do |action,req|
        it "should reach the #{action} page" do
          send(req, action, id:@model.id, day:{date:Date.parse('2012-7-2')}, month:'2012/7')
          response.redirect_url.should_not eq welcome_url
        end
      end
    end
  end
end
