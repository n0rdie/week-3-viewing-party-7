class LoginController < ApplicationController
    def new 
        
    end 
  
    def create
        user = User.find_by(email: params[:email])
        if user.authenticate(params[:password])
            redirect_to "/users/#{user.id}"
        else
            flash[:error] = "Sorry, your credentials are bad."
            redirect_to '/login'
        end
    end 
  end 