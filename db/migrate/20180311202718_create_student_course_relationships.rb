class CreateStudentCourseRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :student_course_relationships do |t|
      t.integer :user_id
      t.integer :course_id
      t.float :grade
      t.timestamps
    end
    add_index :student_course_relationships, :user_id
    add_index :student_course_relationships, :course_id
    # Ensure a student can't be enrolled in a class more than once
    add_index :student_course_relationships, [:user_id, :course_id],
              unique: true
  end
end
