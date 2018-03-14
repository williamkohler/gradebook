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
    assert_equal @teacher, @math.teacher
  end

  test 'should remove teacher' do
    assert_not @bio.teacher_id?
    @teacher.teach @bio
    assert_equal @teacher, @bio.teacher
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
    assert_equal 2, @student.course_grade(@math)
  end

  test 'should get course enrollment count' do
    @student.enroll @math
    @student_2.enroll @math
    assert_equal 2, @math.enrollment
    # Still get correct enrollment after a student drops the course.
    @student.drop @math
    assert_equal 1, @math.enrollment
  end

  test 'should get the average grade for the course' do
    @student.enroll @math
    @student_2.enroll @math
    @math.grade_student(@student, 3.33)
    @math.grade_student(@student_2, 2.5)
    assert_equal 2.92, @math.average_grade
  end

  test 'should get correct letter grades' do
    assert_equal "A", Course.letter_grade(4)
    assert_equal "A-", Course.letter_grade(3.8)
    assert_equal "B", Course.letter_grade(3.1)
    assert_equal "C+", Course.letter_grade(2.33)
    assert_equal "F", Course.letter_grade(0.66)
  end
end
