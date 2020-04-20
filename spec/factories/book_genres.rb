FactoryBot.define do
  factory :book_genre do
    association :book
    association :genre
  end
end
