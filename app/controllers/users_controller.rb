class UsersController < ApplicationController
  def home
    render 'users/home'
  end

  def show
    render 'users/show'
  end
end
