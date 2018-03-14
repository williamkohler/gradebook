class StudentCourseRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :course
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :grade, presence: true, inclusion: 0..4
end
