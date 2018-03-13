require 'test_helper'

class CourseTest < ActiveSupport::TestCase

  def setup
    @student = users(:student)
    @teacher = users(:teacher)
    @admin = users(:admin)
    @bio = courses(:biology)
    @math = courses(:math)
  end

  test 'should get teacher' do
    assert_not @math.teacher_id?
    @teacher.teach @math
    assert @math.teacher == @teacher
  end

  test 'should remove teacher' do
    assert_not @bio.teacher_id?
    @teacher.teach @bio
    assert @bio.teacher == @teacher
    @bio.remove_teacher
    @bio.reload
    assert_not @bio.teacher_assigned?
  end

  test 'course should grade student' do
    @student.enroll @math
    assert @math.students.include? @student
    assert @student.courses.include? @math
    @math.grade_student @student, 2
    assert @student.course_grade(@math) == 2
  end
end
