require 'test_helper'

class StudentCourseRelationshipTest < ActiveSupport::TestCase

  def setup
    @student = users(:student)
    @student_2 = users(:student_2)
    @teacher = users(:teacher)
    @admin = users(:admin)
    @bio = courses(:biology)
    @math = courses(:math)
    @relationship = StudentCourseRelationship.create!(user_id: @student.id,
                                                      course_id: @math.id)
  end

  test 'grade should be invalid' do
    assert @relationship.valid?
    new_relationship = StudentCourseRelationship.new(user_id: @student_2.id,
                                                     course_id: @math.id)
    # Grade can't be greater than 4
    new_relationship.grade = 6.2
    assert_not new_relationship.valid?
    # Grade can't be less than 0
    new_relationship.grade = -1.4
    assert_not new_relationship.valid?
    #Grade is the correct range
    new_relationship.grade = 3.33
    assert new_relationship.valid?
  end


end
