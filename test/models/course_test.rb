require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  def setup
    @student = users(:student)
    @student_2 = users(:student_2)
    @teacher = users(:teacher)
    @admin = users(:admin)
    @bio = courses(:biology)
    @math = courses(:math)
  end

  test 'should get teacher' do
    assert_not @math.teacher_id?
    @teacher.teach @math
    assert_equal @math.teacher, @teacher
  end

  test 'should remove teacher' do
    assert_not @bio.teacher_id?
    @teacher.teach @bio
    assert_equal @bio.teacher, @teacher
    @bio.remove_teacher
    @bio.reload
    assert_not @bio.teacher_assigned?
  end

  test 'course should grade student' do
    @student.enroll @math
    assert @math.students.include? @student
    assert @student.courses.include? @math
    @math.grade_student @student, 2
    @student.reload
    assert_equal @student.course_grade(@math), 2
  end

  test 'should get course enrollment count' do
    @student.enroll @math
    @student_2.enroll @math
    assert_equal @math.enrollment, 2
    # Still get correct enrollment after a student drops the course.
    @student.drop @math
    assert_equal @math.enrollment, 1
  end

  test 'should get the average grade for the course' do
    @student.enroll @math
    @student_2.enroll @math
    @math.grade_student(@student, 3.33)
    @math.grade_student(@student_2, 2.5)
    assert_equal @math.average_grade, 2.915
  end
end
