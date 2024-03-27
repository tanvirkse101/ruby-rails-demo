FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password_digest { User.digest('password') }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin do
      admin { true }
    end

    trait :inactive do
      activated { false }
    end

    factory :tanaka do
      name { "Tanaka Example" }
      email { "tanaka@example.com" }
      admin { true }
      activated { true }
    end

    factory :hiro do
      name { "Sterling Hiro" }
      email { "hiro@example.gov" }
      activated { false }
    end

  end
end
