Title.create!(
   name: 'レコメビギナー'
)
Title.create!(
   name: 'レコメベテラン'
)
Title.create!(
   name: 'レコメマスター'
)

User.create!(
   name: 'やまだ',
   email: 'tesu@tesu.com',
   password: ENV['ADMIN_PASSWORD'],
   password_confirmation: ENV['ADMIN_PASSWORD'],
   admin: true
)
