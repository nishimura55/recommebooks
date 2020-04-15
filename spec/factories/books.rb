FactoryBot.define do
  factory :book do
    sequence(:title, 1) { |n| "テスト本#{n}"}
    story { "伝説の男の物語" }
    contributor_review { "稀代の名作" }
    recomme_evaluation_point { 0 }
    sequence(:rakuten_url, 1) { |n| "https://www.rakuten.co.jp/#{n}" }
    association :user
    association :author
  end

  trait :invalid_book do
    contributor_review { nil }
  end

end
