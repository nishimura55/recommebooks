FactoryBot.define do
  factory :book_feeling do
    association :book
    association :feeling
  end
end
