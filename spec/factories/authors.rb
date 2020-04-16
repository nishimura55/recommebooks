FactoryBot.define do
  factory :author do
    sequence(:name, 1) { |n| "テスト著者#{n}"}
  end
end