# Users
User.create!(name: 'Bill Kohler',
             email: 'bkohler4@gmail.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
