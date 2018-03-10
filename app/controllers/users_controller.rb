class UsersController < ApplicationController
  def index
  end

  def new
    redirect_to current_user if logged_in?
    @user = User.new
  end

  def edit
  end
end
