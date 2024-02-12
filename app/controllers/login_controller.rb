class LoginController < ApplicationController
    def new 
        
    end 
  
    def create
        user = User.find_by(email: params[:email])
        redirect_to "/users/#{user.id}"
    end 
  end 