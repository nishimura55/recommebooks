# coding: utf-8mb4

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
   password: 'ENV['ADMIN_PASSWORD']',
   admin: true
)
