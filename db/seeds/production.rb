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
Genre.create!(
    division: 2,
    name: '社会・ビジネス'
)
Genre.create!(
    division: 2,
    name: '時事'
)
Genre.create!(
    division: 2,
    name: 'ビジネス'
)
Genre.create!(
    division: 2,
    name: '環境'
)
Genre.create!(
    division: 2,
    name: '生き方'
)
Genre.create!(
    division: 2,
    name: '自己啓発'
)
Genre.create!(
    division: 2,
    name: '伝記'
)
Genre.create!(
    division: 2,
    name: '政治'
)
Genre.create!(
    division: 2,
    name: '法律'
)
Genre.create!(
    division: 3,
    name: '趣味・実用'
)
Genre.create!(
    division: 3,
    name: '登山'
)
Genre.create!(
    division: 3,
    name: '釣り'
)
Genre.create!(
    division: 3,
    name: 'アウトドア'
)
Genre.create!(
    division: 3,
    name: 'スポーツ'
)
Genre.create!(
    division: 3,
    name: 'IT'
)
Genre.create!(
    division: 3,
    name: '技術書'
)
Genre.create!(
    division: 3,
    name: '鉄道'
)
Genre.create!(
    division: 3,
    name: '植物'
)
Genre.create!(
    division: 3,
    name: '自然'
)
Genre.create!(
    division: 3,
    name: 'ペット'
)
Genre.create!(
    division: 3,
    name: '手芸'
)
Genre.create!(
    division: 3,
    name: '占い'
)
Genre.create!(
    division: 3,
    name: 'おもちゃ'
)
Genre.create!(
    division: 4,
    name: '芸術・教養・エンタメ'
)
Genre.create!(
    division: 4,
    name: '映画'
)
Genre.create!(
    division: 4,
    name: '音楽'
)
Genre.create!(
    division: 4,
    name: '舞台'
)
Genre.create!(
    division: 4,
    name: '古典'
)
Genre.create!(
    division: 4,
    name: '美術'
)
Genre.create!(
    division: 4,
    name: '建築'
)
Genre.create!(
    division: 4,
    name: 'イラスト'
)
Genre.create!(
    division: 4,
    name: 'デザイン'
)
Genre.create!(
    division: 4,
    name: 'アート'
)
Genre.create!(
    division: 4,
    name: '写真集'
)
Genre.create!(
    division: 4,
    name: 'タレント'
)
Genre.create!(
    division: 4,
    name: '日本史'
)
Genre.create!(
    division: 4,
    name: '世界史'
)
Genre.create!(
    division: 4,
    name: '科学'
)
Genre.create!(
    division: 4,
    name: '宗教'
)
Genre.create!(
    division: 4,
    name: '文化'
)
Genre.create!(
    division: 4,
    name: '語学'
)
Genre.create!(
    division: ５,
    name: '旅行・地図'
)
Genre.create!(
    division: ５,
    name: '海外旅行'
)
Genre.create!(
    division: ５,
    name: '国内旅行'
)
Genre.create!(
    division: ５,
    name: '地図'
)
Genre.create!(
    division: ５,
    name: '世界遺産'
)
Genre.create!(
    division: 6,
    name: '暮らし・健康'
)
Genre.create!(
    division: 6,
    name: 'クッキング'
)
Genre.create!(
    division: 6,
    name: 'グルメ'
)
Genre.create!(
    division: 6,
    name: '恋愛'
)
Genre.create!(
    division: 6,
    name: '家事'
)
Genre.create!(
    division: 6,
    name: 'インテリア'
)
Genre.create!(
    division: 6,
    name: '家庭医学'
)
Genre.create!(
    division: 7,
    name: '図鑑・辞書'
)
Genre.create!(
    division: 7,
    name: '百科事典'
)
Genre.create!(
    division: 7,
    name: '図鑑'
)
Genre.create!(
    division: 7,
    name: '辞書'
)
Genre.create!(
    division: 8,
    name: 'こども'
)
Genre.create!(
    division: 8,
    name: '絵本'
)
Genre.create!(
    division: 8,
    name: '学習'
)
Genre.create!(
    division: 8,
    name: 'ゲーム攻略本'
)
Genre.create!(
    division: 8,
    name: '教科書'
)
Genre.create!(
    division: 9,
    name: 'コミック'
)

Feeling.create!(
    situation: '勇気をだしたい時'
)
Feeling.create!(
    situation: '落ち込んでいる時'
)
Feeling.create!(
    situation: '泣きたい時'
)
Feeling.create!(
    situation: '感動したい時'
)
Feeling.create!(
    situation: '笑いたい時'
)
Feeling.create!(
    situation: '勉強をしたい時'
)
Feeling.create!(
    situation: '知的好奇心を満たしたい時'
)
Feeling.create!(
    situation: 'モチベーションを上げたい時'
)
Feeling.create!(
    situation: '頭を空っぽにしたい時'
)
Feeling.create!(
    situation: 'スカッとしたい時'
)




