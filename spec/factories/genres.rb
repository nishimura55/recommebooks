FactoryBot.define do
  factory :genre do
    #sequence(:name, 1) { |n| "テストジャンル#{n}"}
    name {"文学・小説" }
    division { 1 }
  end
end
