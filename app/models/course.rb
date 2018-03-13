class Course < ApplicationRecord
  has_many :student_course_relationships
  has_many :users, through: :student_course_relationships
  alias_attribute :students, :users

  def teacher
    User.find(teacher_id)
  end

  def remove_teacher
    teacher_id = nil
  end

  # Check if a teacher has been assigned to a course.
  def teacher_assigned?
    teacher_id?
  end

  def course_enrollment
    StudentCourseRelationship.where(course_id: id).count
  end

  # Calculates the average grade for a course
  def average_grade
  end

  def grade_student(student, grade)
    relationship = StudentCourseRelationship.where(course_id: id,
                                                   user_id: student.id).first
    relationship.grade = grade
    relationship.save!
  end

end
