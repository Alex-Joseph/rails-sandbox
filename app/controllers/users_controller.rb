class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery prepend: true
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.all
  end
  
  def create
      @user = User.new(user_params)
    
    if @user.save
      redirect_to 
    else
      redirect_to new_user_path
      flash[:alert] = 'save unsuccessful'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
    
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :phone)
  end
end
