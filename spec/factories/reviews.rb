FactoryBot.define do
  factory :review do
    association :book   
    association :user
    title { "最高に面白かった" }
    content { "老若男女におすすめしたい稀代の名作" }
  end

  trait :invalid_review do
    content { nil }
  end

  trait :update_review do
    content { "アップデイト老若男女におすすめしたい稀代の名作" }
  end

end
