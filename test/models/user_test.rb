require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @student = users(:student)
    @teacher = users(:teacher)
    @admin = users(:admin)
    @bio = courses(:biology)
    @math = courses(:math)
  end

  test 'should enroll in a course' do
    assert_difference 'StudentCourseRelationship.count', 1 do
      @student.enroll @math
    end
  end

  test 'should drop a course' do
    @student.enroll @math
    assert_difference 'StudentCourseRelationship.count', -1 do
      @student.drop @math
    end
    assert_not @student.courses.include? @math
  end

  test 'should teach course' do
    assert_not @math.teacher_assigned?
    @teacher.teach @math
    assert @math.teacher == @teacher
  end

  # TODO: finish test (when to reload teacher & class)
  test 'teacher should get courses taught' do
    assert @teacher.teacher?
    assert_equal(@teacher.courses_taught.count, 0)
    @teacher.teach @math
    @teacher.teach @bio
    @teacher.reload
  end

  test 'should calculate gpa' do
    @student.enroll @math
    @student.enroll @bio
    @math.grade_student(@student, 3)
    @bio.grade_student(@student, 4)
    assert_equal(3.5, @student.gpa)
  end
end
