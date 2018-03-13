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
    assert_not @math.teacher_assigned?
    @teacher.teach @math
    assert @math.teacher == @teacher
  end

  test 'should remove teacher' do
    assert_not @bio.teacher_assigned?
    @teacher.teach @bio
    assert @bio.teacher == @teacher
    @bio.remove_teacher
    @bio.reload
    assert_not @bio.teacher_assigned?
  end
end
