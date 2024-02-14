require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")
  end 

  it "6: Dashboard Authorization" do
    # When I visit the landing page
    visit '/'
    # And then try to visit the user's dashboard ('/users/:user_id')
    visit "/users/#{@user1.id}"
    # I remain on the landing page
    expect(current_path).to eq('/')
    # And I see a message telling me that I must be logged in or registered to access a user's dashboard.
    expect(page).to have_content('must be logged in')
  end
end
