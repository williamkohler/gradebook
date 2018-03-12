class Course < ApplicationRecord
  has_many :student_relationships, class_name: "Relationship",
                                   foreign_key: "student_id"
  has_one :teacher_relationship,  class_name: "Relationship",
                                   foreign_key: "teacher_id"
  has_many :students, through: :student_relationships, source: :student
  has_one  :teacher, through: :teacher_relationship, source: :teacher
end
