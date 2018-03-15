class CoursesController < ApplicationController
  before_action :faculty_check

  def index
    @courses = Course.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @course = Course.find(params[:id])
    @students = @course.students.paginate(page: params[:page], per_page: 10)
  end

  # TODO: write update controller tests
  def update
    @course = Course.find(course_params[:course_id])
    @teacher = User.find(course_params[:teacher_id])
    if course_params[:drop_teacher]
      @course.remove_teacher
      flash[:warning] = "You are no longer teaching #{@course.name}."
      redirect_to @teacher
    elsif course_params[:add_teacher]
      @teacher.teach @course
      flash[:success] = "You are now teaching #{@course.name}."
      redirect_to @course
    else
      redirect_to root_path
    end
  end

  def course_params
    params.require(:course).permit(:course_id, :teacher_id, :drop_teacher,
                                   :add_teacher)
  end
end
