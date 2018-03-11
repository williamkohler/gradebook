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
  User.create!(name: name,
               email: "example#{n+1}@thelodge.com",
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
