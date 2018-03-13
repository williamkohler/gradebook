class Course < ApplicationRecord
  has_many :student_course_relationships
  has_many :users, through: :student_course_relationships
  alias_attribute :students, :users

  def teacher
    User.find(teacher_id)
  end

  # Check if a teacher has been assigned to a course.
  def teacher_assigned?
    teacher_id.present?
  end

end