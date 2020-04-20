FactoryBot.define do
  factory :genre do
    sequence(:name, 1) { |n| "テストジャンル#{n}"}
    division { 1 }
  end
end
