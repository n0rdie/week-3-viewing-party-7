class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    if params[:id].to_s == session[:user_id].to_s
      @user = User.find(params[:id])
    else
      flash[:error] = "must be logged in or registered to access a user's dashboard"
      redirect_to '/'
    end
  end 

  def create 
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 