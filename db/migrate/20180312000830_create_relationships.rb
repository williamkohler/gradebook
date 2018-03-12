class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.integer :course_id

      t.timestamps
    end
    # Ensure a student can't enroll in the same course twice
    add_index :relationships, [:student_id, :course_id], unique: true
    # Ensure a teacher can't be assigned the same course twice
    add_index :relationships, [:teacher_id, :course_id], unique: true
  end
end
