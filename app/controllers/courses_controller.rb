class CoursesController < ApplicationController
  before_action :teacher_check,      only: %i[index]


  def index
    @courses = Course.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @course = Course.find(params[:id])
    @students = @course.students.paginate(page: params[:page], per_page: 10)
  end


end
