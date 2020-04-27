FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user    
    association :visited, factory: :user
    association :recommend
    action { "" }
    checked { false }
  end
end
