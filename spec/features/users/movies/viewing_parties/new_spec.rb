require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    i = 1
    20.times do 
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
      i+=1
    end 
  end 

  it "6: Dashboard Authorization" do
    # If I go to a movies show page ('/users/:user_id/movies/:movie_id')
    visit "/users/#{@user1.id}/movies/#{Movie.first.id}"
    # And click the button to Create a Viewing Party
    click_button('Create a Viewing Party')
    # I'm redirected back to the movies show page, 
    expect(current_path).to eq("/users/#{@user1.id}/movies/#{Movie.first.id}")
    # and a message appears to let me know I must be logged in or registered to create a Viewing Party. 
    expect(page).to have_content('must be logged in')
  end
end
