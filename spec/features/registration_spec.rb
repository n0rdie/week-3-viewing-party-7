require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: "password123", password_confirmation: "password123")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it "User Story #1 - Registration (w/ Authentication) Happy Path" do
    # When I visit `/register`
    visit '/register'
    # I see a form to fill in my name, email, password, and password confirmation.
    expect(page).to have_field(:user_name)
    expect(page).to have_field(:user_email)
    expect(page).to have_field(:user_password)
    expect(page).to have_field(:user_password_confirmation)
    # When I fill in that form with my name, email, and matching passwords,
    fill_in :user_name,  with: 'User Two'
    fill_in :user_email, with: 'notunique@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'
    # I'm taken to my dashboard page `/users/:id`
    expect(page).to have_content("User Two's Dashboard")
  end

  it "User Story #2 - Registration (w/ Authentication) Sad Path - Passwords do not match" do
    # When I visit `/register`
    visit '/register'
    # and I fail to fill in my name, unique email, OR matching passwords,
    fill_in :user_name,  with: 'User Two'
    fill_in :user_email, with: 'notunique@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Create New User'
    # I'm taken back to the `/register` page
    expect(current_path).to eq('/register')
    # and a flash message pops up, telling me what went wrong
    expect(page).to have_content("Password confirmation doesn't match")
  end

  it "User Story #2 - Registration (w/ Authentication) Sad Path - No name" do
    # When I visit `/register`
    visit '/register'
    # and I fail to fill in my name, unique email, OR matching passwords,
    fill_in :user_name,  with: ''
    fill_in :user_email, with: 'notunique@example.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'
    # I'm taken back to the `/register` page
    expect(current_path).to eq('/register')
    # and a flash message pops up, telling me what went wrong
    expect(page).to have_content("Name can't be blank")
  end

  it "User Story #2 - Registration (w/ Authentication) Sad Path - No email" do
    # When I visit `/register`
    visit '/register'
    # and I fail to fill in my name, unique email, OR matching passwords,
    fill_in :user_name,  with: 'User Two'
    fill_in :user_email, with: ''
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    click_button 'Create New User'
    # I'm taken back to the `/register` page
    expect(current_path).to eq('/register')
    # and a flash message pops up, telling me what went wrong
    expect(page).to have_content("Email can't be blank")
  end

  it "User Story #2 - Registration (w/ Authentication) Sad Path - No password" do
    # When I visit `/register`
    visit '/register'
    # and I fail to fill in my name, unique email, OR matching passwords,
    fill_in :user_name,  with: 'User Two'
    fill_in :user_email, with: 'notunique@example.com'
    fill_in :user_password, with: ''
    fill_in :user_password_confirmation, with: ''
    click_button 'Create New User'
    # I'm taken back to the `/register` page
    expect(current_path).to eq('/register')
    # and a flash message pops up, telling me what went wrong
    expect(page).to have_content("Password can't be blank")
  end
end
