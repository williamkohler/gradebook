require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @student = users(:student)
    @teacher = users(:teacher)
    @admin = users(:admin)
    @bio = courses(:biology)
    @math = courses(:math)

  end



  test 'should enroll in a class' do
    assert_difference 'StudentCourseRelationship.count', 1 do
      @student.enroll @math
    end
  end

  # TODO: finish test
  test 'should drop in a class' do
    @student.enroll @math
    assert_difference 'StudentCourseRelationship.count', -1 do
      @student.drop @math
    end
  end
end
