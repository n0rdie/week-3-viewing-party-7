require 'rails_helper'

RSpec.describe 'Landing Page' do
    before(:each) do 
        @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
        @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")
        visit '/'
    end 

    it '3: Log out a user' do
        # As a logged-in user 
        click_on "Log In"
        fill_in :email, with: "user1@test.com"
        fill_in :password, with: "password123"
        fill_in :location, with: "Denver, CO"
        click_button "Log In"
        # When I visit the landing page
        visit '/'
        # I no longer see a link to Log In or Create an Account
        expect(page).to_not have_content("Log In")
        expect(page).to_not have_button("Create an Account")
        # But I only see a link to Log Out.
        expect(page).to have_content("Log Out")
        # When I click the link to Log Out,
        click_on "Log Out"
        # I'm taken to the landing page
        expect(current_path).to eq('/')
        # And I see that the Log Out link has changed back to a Log In link
        expect(page).to have_content("Log In")
        expect(page).to_not have_content("Log Out")
        # And I still see the Create an Account button. 
        expect(page).to have_button("Create New User")
    end

    it "2: Remember a user upon successful log in/registration" do
        # when I log in successfully
        click_on "Log In"
        fill_in :email, with: "user1@test.com"
        fill_in :password, with: "password123"
        fill_in :location, with: "Denver, CO"
        click_button "Log In"
        # and then leave the website and navigate to a different website entirely,
        visit "http://www.google.com"
        # Then when I return to *this* website, 
        visit "/users/#{@user1.id}"
        # I see that I am still logged in. 
        expect(page).to have_content("User One's Dashboard")
    end
end