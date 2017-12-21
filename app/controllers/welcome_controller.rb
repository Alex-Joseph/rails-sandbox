class WelcomeController < ApplicationController
  def index
    @user = User.new
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user
    else
      render 'index'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :phone)
  end
  
end
