# Users
User.create!(name: 'Bill Kohler',
             email: 'bkohler4@gmail.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: 'Admin User',
            email: 'admin@example.com',
            password: 'foobar',
            password_confirmation: 'foobar',
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

User.create!(name: 'Standard User',
            email: 'user@example.com',
            password: 'foobar',
            password_confirmation: 'foobar',
            admin: false,
            activated: true,
            activated_at: Time.zone.now)

97.times do |n|
  name = Faker::TwinPeaks.character
  password = 'foobar'
  User.create!(name: name,
               email: "example#{n+1}@thelodge.com",
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
