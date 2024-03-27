FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence(word_count: 15) }
    created_at { 42.days.ago }
    association :user, factory: :user
    association :micropost, factory: :micropost
  end
end
