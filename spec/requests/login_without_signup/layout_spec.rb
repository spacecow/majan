require 'spec_helper'

describe User do
  describe "attributes" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "email exists" do
      @user.should respond_to :email
    end
    it "userid exists" do
      @user.should respond_to :userid
    end
    it "roles_mask exists" do
      @user.should respond_to :roles_mask
    end
    it "password exists" do
      @user.should respond_to :password
    end
    it "password confirmation exists" do
      @user.should respond_to :password_confirmation
    end
    it "password digest exists" do
      @user.should respond_to :password_digest
    end
  end
end

describe 'Sessions new layout' do
  before(:each) do
    visit login_path
  end

  it "has a title" do
    page.should have_title('Login')
  end

  it "has an empty login field" do
    value('Login').should be_nil
  end
  it "has an empty password field" do
    value('Password').should be_nil
  end
  it "has a login button" do
    form.should have_submit_button('Login')
  end
end

describe 'Usernav layout' do
  context "for logged out user" do
    before(:each) do
      visit root_path
    end

    it "has a login link" do
      user_nav.should have_link('Login')
      user_nav.click_link 'Login'
      page.current_path.should eq login_path
    end

    it "has no logout link" do
      user_nav.should_not have_link('Logout')
    end
  end

  context "for logged in user" do
    before(:each) do
      FactoryGirl.create(:user, userid:'testuser')
      visit login_path
      fill_in 'Login', with:'testuser'
      fill_in 'Password', with:'secret'
      click_button 'Login'
    end

    it "has a logout link" do
      user_nav.should have_link('Logout')
      user_nav.click_link 'Logout'
      page.current_path.should eq root_path
    end

    it "has no login link" do
      user_nav.should_not have_link('Login')
    end
  end
end
