class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string  :name
      t.string  :description
      t.integer :credit
      t.integer :seats

      t.timestamps
    end
  end
end
