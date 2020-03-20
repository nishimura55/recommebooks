FactoryBot.define do
  factory :book do
    sequence(:title, 1) { |n| "テスト本#{n}"}
    story { "伝説の男の物語" }
    contributor_review { "稀代の名作" }
    recomme_evaluation_point { 0 }
    image { "MyString" }
    association :user
  end
end
