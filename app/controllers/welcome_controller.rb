class WelcomeController < ApplicationController 
  def index 
    @users = User.all
    @logged_in = false
    if session[:user_id]
      @logged_in = true
    end
  end 
end 