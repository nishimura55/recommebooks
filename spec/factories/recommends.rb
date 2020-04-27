FactoryBot.define do
  factory :recommend do
    association :recommender, factory: :user    
    association :recommended, factory: :user
    association :book
    body { "とてもおすすめです！" }
    status { 1 }
  end
end
