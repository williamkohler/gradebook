class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # Confirms a logged-in user
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) || current_user.admin
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(user_path(current_user)) unless current_user.admin?
  end

  def teacher_check
    redirect_to(user_path(current_user)) unless current_user.teacher?
  end

  def student_check
    redirect_to(user_path(current_user)) unless current_user.student?
  end



end
