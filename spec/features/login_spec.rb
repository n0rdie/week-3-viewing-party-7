require 'rails_helper'

RSpec.describe 'Landing Page' do
    before :each do 
        user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
        user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")
        visit '/'
    end 

    it 'User Story #3 - Logging In Happy Path' do
        # I see a link for "Log In"
        expect(page).to have_content("Log In")
        # When I click on "Log In"
        click_on "Log In"
        # I'm taken to a Log In page ('/login') where I can input my unique email and password.
        expect(current_path).to eq('/login')
        expect(page).to have_field(:email)
        expect(page).to have_field(:password)
        # When I enter my unique email and correct password 
        fill_in :email, with: "user1@test.com"
        fill_in :password, with: "password123"
        click_button "Log In"
        # I'm taken to my dashboard page
        expect(page).to have_content("User One's Dashboard")
    end

    it 'User Story #4 - Logging In Sad Path' do
        # And click on the link to go to my dashboard
        click_on "Log In"
        # And fail to fill in my correct credentials 
        fill_in :email, with: "user1@test.com"
        fill_in :password, with: "wrong"
        click_button "Log In"
        # I'm taken back to the Log In page
        expect(current_path).to eq("/login")
        # And I can see a flash message telling me that I entered incorrect credentials.
        expect(page).to have_content("Sorry, your credentials are bad.")
    end

    it "1: Implement a Cookie" do
        # when I go to the login page (/login)
        click_on "Log In"
        # Under the normal login fields (username, password)
        fill_in :email, with: "user1@test.com"
        fill_in :password, with: "password123"
        # I also see a text input field for "Location"
        expect(page).to have_field(:location)
        # When I enter my city and state in this field (e.g. "Denver, CO")
        fill_in :location, with: "Denver, CO"
        # and successfully log in
        click_button "Log In"
        # I see my location on the landing page as I entered it.
        expect(page).to have_content("Denver, CO")
        # Then, when I log out and return to the login page
        visit '/login'
        # I still see my location that I entered previously already typed into the Location field.
        expect(page).to have_field "Location:", with: "Denver, CO"
    end
end