class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "Account created!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  
  private
    
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
    
end
