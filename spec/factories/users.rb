FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "テストユーザー#{n}"}
    sequence(:email) { |n| "test#{n}@example.com"}
    password { 'password' }
    password_confirmation { 'password' }
    favorite_genre { 'ミステリーが好きです' }
    profile { '大学生です。ハラハラ系のミステリーに目がありません。' }
  end
end
