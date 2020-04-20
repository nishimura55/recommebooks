FactoryBot.define do
  factory :feeling do
    sequence(:situation, 1) { |n| "テスト#{n}の時"}
  end
end
