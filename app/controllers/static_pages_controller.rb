class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @user = current_user
      @notes = @user.notes
    end
  end
  
end
