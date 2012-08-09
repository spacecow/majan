require 'spec_helper'

describe 'Sessions create' do
  it "redirect to wanted page after login" do
    FactoryGirl.create(:user, userid:'testuser')
    member = create_member
    visit user_path(member)
    fill_in 'Login', with:'testuser'
    fill_in 'Password', with:'secret'
    click_button 'Login'
    current_path.should eq user_path(member)
  end
end

describe 'Sessions create' do
  before(:each) do
    FactoryGirl.create(:user, userid:'testuser', email:'test@email.com')
    visit login_path
    fill_in 'Login', with:'testuser'
    fill_in 'Password', with:'secret'
  end

  it "login with email" do
    fill_in 'Login', with:'test@email.com'
    click_button 'Login'
    user_nav.should have_content('Logged in as testuser')
  end

  context "login with userid" do
    before(:each) do
      click_button 'Login'
    end

    it "redirects to the root page" do
      current_path.should eq root_path
    end

    it "shows a logged-in flash message" do
      page.should have_notice('Logged in')
    end

    it "shows the name of the logged in user" do
      user_nav.should have_content('Logged in as testuser')
    end
  end

  context "errors" do
    it "login must be correct" do
      fill_in 'Login', with:''
      click_button 'Login'
      page.should have_alert('Invalid login or password')
    end
    it "password must be correct" do
      fill_in 'Password', with:''
      click_button 'Login'
      page.should have_alert('Invalid login or password')
    end
  end
end
