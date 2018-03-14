require 'test_helper'

class StudentCourseRelationshipTest < ActiveSupport::TestCase

  def setup
    @student = users(:student)
    @student_2 = users(:student_2)
    @teacher = users(:teacher)
    @admin = users(:admin)
    @bio = courses(:biology)
    @math = courses(:math)
  end

  test 'grade should be invalid' do
  end


end
