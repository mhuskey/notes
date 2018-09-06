class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  
  private
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
    
    # Confirms the correct user is logged in.
    def correct_user
      unless @user == current_user
        redirect_to user_notes_path(current_user)
      end
    end
    
end
