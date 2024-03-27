# spec/factories/groups.rb
FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    association :creator, factory: :user

    factory :example_group, class: Group do
      name { "Example Group" }
      creator { create(:tanaka) }
    end

    factory :another_group, class: Group do
      name { "Another Group" }
      creator { create(:hiro) }
    end
  end
end
