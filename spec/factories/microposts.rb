FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence(word_count: 5) }
    created_at { 42.days.ago }
    association :user

    factory :orange, class: Micropost do
      user { :tanaka }
      content { "I just ate an orange" }
      created_at { 365.days.ago }
    end

    factory :ants, class: Micropost do
      user { :hiro }
      content { "Oh, is that what you want? Because that's how you get ants!" }
      created_at { 365.days.ago }
    end

  end
end
