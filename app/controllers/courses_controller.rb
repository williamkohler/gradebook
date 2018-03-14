class CoursesController < ApplicationController
  def index
    @courses = Course.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @course = Course.find(params[:id])
    @students = @course.students
  end


end
