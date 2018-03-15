class StudentCourseRelationshipsController < ApplicationController
  before_action :build_relationship, only: :create

  def create
    if @relationship.save
      flash
      flash[:success] = "#{@contact.name} now enrolled in #{@course.name}."
    else
      flash[:warning] = "Unable to enroll in class."
    end
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @relationship = StudentCourseRelationship.find(params[:id])
    @user = User.find(@relationship[:user_id])
    @course = Course.find(@relationship[:course_id])
    @relationship.destroy
    flash[:warning] = "#{@contact.name} no longer enrolled in #{@course.name}."
    redirect_back(fallback_location: root_url)
  end

  private

  def relationship_params
    params.require(:relationship).permit(:user_id, :course_id)
  end

  # Before filters

  def build_relationship
    @user = User.find(relationship_params[:user_id])
    @course = Course.find(relationship_params[:course_id])
    @relationship = StudentCourseRelationship.new
    if @user.student?
      @relationship = StudentCourseRelationship.new(user_id: @user.id,
                                                    course_id: @course.id)
    end
  end
end
