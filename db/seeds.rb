# Users
User.create!(name: 'Bill Kohler',
             email: 'bkohler4@gmail.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             role: :admin,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: 'Admin User',
            email: 'admin@example.com',
            password: 'foobar',
            password_confirmation: 'foobar',
            role: :admin,
            activated: true,
            activated_at: Time.zone.now)

User.create!(name: 'Teacher User',
            email: 'teacher@example.com',
            password: 'foobar',
            password_confirmation: 'foobar',
            role: :teacher,
            activated: true,
            activated_at: Time.zone.now)

User.create!(name: 'Student User',
            email: 'student@example.com',
            password: 'foobar',
            password_confirmation: 'foobar',
            role: :student,
            activated: true,
            activated_at: Time.zone.now)

96.times do |n|
  name = Faker::TwinPeaks.character
  password = 'foobar'
  roles = [:student, :teacher, :admin]
  User.create!(name: name,
               email: "example#{n+1}@thelodge.com",
               password: password,
               password_confirmation: password,
               role: roles.sample,
               activated: true,
               activated_at: Time.zone.now)
end

# Courses
course_names = ["Biology", "Calculus", "Algebra", "American Literature",
                "World History", "U.S. History", "Spanish", "French"]
levels = [101, 202, 303]
50.times do
  Course.create!(name: "#{course_names.sample} #{levels.sample}",
                 description: Faker::Lorem.sentence(8),
                 credit: 4,
                 seats: 30,
                 teacher_id: User.teacher.sample.id)
end

# Student Enrollment
User.student.each do |student|
  4.times do
    course = Course.find(rand(1..Course.count))
    student.enroll(course) if student.courses.exclude?(course)
  end
end

# Grades
StudentCourseRelationship.all.each do |relationship|
  relationship.update_attribute(:grade, rand(1.1..4).round(2))
  relationship.save!
end

# Teacher Courses
teacher = User.find_by(email: 'teacher@example.com')
Course.take(5).each do |course|
  teacher.teach(course)
end
