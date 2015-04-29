require 'rails_helper'

feature 'Site Controller' do
  before(:each) do
    @appName = 'Tracker App'
  end

  context "Unsigned User" do
    scenario "Unsigned user visit welcome page" do
      visit root_path
      expect(page).to have_title("#{@appName} | Welcome")     
    end

    scenario "Unsigned user visit dashboard page" do
      visit dashboard_path
      expect(page).to have_title("#{@appName} | Sign In") 
    end 
  end
  
  scenario "Signed user visit welcome page", js: true do
    visit signin_path
    email = 'person@example.com'
    password = 'password123'
    user = FactoryGirl.create(:user, email: email, password: password) 
    print "password_digest = #{user.password_digest}"
    print "remember_tocken = #{user.remember_token}"
    within('#sign-in-form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In', exact: true
    end
    print page.driver.cookies[user.remember_token]
    # find_field('Email').value.should eq email
    # find_field('Password').value.should eq password
    #print page.html
    current_path.should == "/dashboard"
    #print page.html

    #expect(page).to have_title("#{@appName} | Welcome")
  end

  scenario "Signed user visit dashboard page" do
#    sign_in_as "dimko.goncharov@gmail.com", "w2nkh72"
#    expect(page).to have_title("#{@appName} | Dashboard")
  end

end