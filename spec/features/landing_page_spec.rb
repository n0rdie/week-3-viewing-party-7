require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")

    click_on "Log In"
    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "password123"
    fill_in :location, with: "Denver, CO"
    click_button "Log In"
    visit '/'

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  it '5: Logged-in users no longer see links on Landing Page' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")

    # As a logged-in user
    click_on "Log In"
    fill_in :email, with: "user1@test.com"
    fill_in :password, with: "password123"
    fill_in :location, with: "Denver, CO"
    click_button "Log In"
    visit '/'

    expect(page).to have_content('Existing Users:')

    # The list of existing users is no longer a link to their show pages
    # But just a list of email addresses
    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
      expect(page).to_not have_link(user1.email)
      expect(page).to_not have_link(user2.email)
    end     
  end
end
