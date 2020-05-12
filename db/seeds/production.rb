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

Genre.create!(
    division: 1,
    name: '文学・小説'
)
Genre.create!(
    division: 1,
    name: '現代小説'
)
Genre.create!(
    division: 1,
    name: 'ミステリー'
)
Genre.create!(
    division: 1,
    name: '歴史小説'
)
Genre.create!(
    division: 1,
    name: '映画原作'
)
Genre.create!(
    division: 1,
    name: 'ノンフィクション'
)
Genre.create!(
    division: 1,
    name: 'ファンタジー'
)
Genre.create!(
    division: 1,
    name: 'SF'
)
Genre.create!(
    division: 1,
    name: 'ホラー'
)
Genre.create!(
    division: 1,
    name: 'ライトノベル'
)
Genre.create!(
    division: 1,
    name: '海外文学'
)
Genre.create!(
    division: 1,
    name: 'エッセー'
)

