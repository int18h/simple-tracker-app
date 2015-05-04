require 'rails_helper'

feature 'Site Controller' do
  let(:appName) { 'Tracker App' }
  let(:user) { FactoryGirl.create :user }
  
  context "when unsigned user visit pages`" do
    scenario "Unsigned user visit welcome page" do
      visit root_path
      expect(page).to have_title("#{@appName} | Welcome")     
    end

    scenario "Unsigned user visit dashboard page" do
      visit dashboard_path
      expect(page).to have_title("#{@appName} | Sign In") 
    end 
  end
  
  context "when signed user visit pages" do
    scenario "Signed user visit welcome page" do
      visit signin_path
      sign_in_as user.email, user.password
      
      expect(current_path).to eq('/dashboard') 
    end
    scenario "Signed user visit dashboard page" do
      visit signin_path
      sign_in_as user.email, user.password

      expect(current_path).to eq('/dashboard')
    end
  end

end