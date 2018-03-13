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
end
