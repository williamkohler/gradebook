class StudentCourseRelationship < ApplicationRecord
  attr_accessor :grade
  belongs_to :user
  belongs_to :course
  validates :user_id, presence: true
  validates :course_id, presence: true
end
