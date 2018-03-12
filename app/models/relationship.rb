class Relationship < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  belongs_to :student, class_name: "User"
  belongs_to :course
  validates :course_id, presence: true
end
