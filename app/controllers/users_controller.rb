class UsersController < ApplicationController
  def profile
    if user_signed_in?
      render 'users/profile'
    else
      redirect_to root_path
    end
  end
end

