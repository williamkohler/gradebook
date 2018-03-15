class Course < ApplicationRecord
  default_scope -> { order(name: :asc) }
  has_many :student_course_relationships
  has_many :users, through: :student_course_relationships
  alias_attribute :students, :users

  def teacher
    User.find(teacher_id) if teacher_id?
  end

  def teacher?
    teacher_id?
  end

  def remove_teacher
    update_attribute(:teacher_id, nil)
  end

  # Check if a teacher has been assigned to a course.
  def teacher_assigned?
    teacher_id?
  end

  def enrollment
    StudentCourseRelationship.where(course_id: id).count
  end

  # Calculates the average grade for a course
  def average_grade
    total = 0
    relationships = StudentCourseRelationship.where(course_id: id)
    if relationships.count > 0
      relationships.each do |relationship|
        total += relationship.grade
      end
      (total / relationships.count).round(2)
    else
      return 0
  end
  end

  def grade_student(student, grade)
    relationship = StudentCourseRelationship.where(course_id: id,
                                                   user_id: student.id).first
    relationship.grade = grade
    relationship.save!
  end

  def self.letter_grade(grade)
    if grade == 4
      'A'
    elsif grade > 3.7
      'A-'
    elsif grade > 3.3
      'B+'
    elsif grade > 3
      'B'
    elsif grade > 2.7
      'B-'
    elsif grade > 2.3
      'C+'
    elsif grade > 1
      'C'
    elsif grade > 1.7
      'C-'
    elsif grade > 1.3
      'D+'
    elsif grade > 1.0
      'D'
    else
      'F'
    end
  end
end
