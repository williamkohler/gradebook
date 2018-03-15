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

  test 'teacher should get courses taught' do
    assert @teacher.teacher?
    assert_equal 0, @teacher.courses_taught.count
    @teacher.teach @math
    @teacher.teach @bio
    @teacher.reload
    assert_equal 2, @teacher.courses_taught.count
  end

  test 'should calculate gpa' do
    @student.enroll @math
    @student.enroll @bio
    @math.grade_student(@student, 3)
    @bio.grade_student(@student, 4)
    assert_equal(3.5, @student.gpa)
  end

  test 'deleting a teacher should also remove the id from course records' do
    @teacher.teach @math
    assert_equal @teacher, @math.teacher
    @teacher.destroy
    @math.reload
    assert_nil nil, @math.teacher
  end

  test 'facutly check' do
    assert @teacher.faculty?
    assert @admin.faculty?
    assert_not @student.faculty?
  end


end
