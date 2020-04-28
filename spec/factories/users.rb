FactoryBot.define do
  factory :user do
    sequence(:name, 1) { |n| "テストユーザー#{n}"}
    sequence(:email, 1) { |n| "test#{n}@example.com"}
    password { 'password' }
    password_confirmation { 'password' }
    favorite_genre { 'ミステリーが好きです' }
    profile { '大学生です。ハラハラ系のミステリーに目がありません。' }
    admin { false }
    title_id { 1 }
    association :title
  end

  trait :admin_user do
    admin { true }
  end

  trait :invalid do
    name { nil }
  end

  trait :update do
    name { "アップデイトユーザー" }
  end
  
end
