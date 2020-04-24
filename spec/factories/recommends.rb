FactoryBot.define do
  factory :recommend do
    recommender_id { 1 }
    recommended_id { 1 }
    book_id { 1 }
    body { "MyString" }
    status { 1 }
  end
end
