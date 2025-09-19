# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    role { "member" }

    trait :guest do
      role { "guest" }
    end

    trait :moderator do
      role { "moderator" }
    end

    trait :with_profile do
      after(:create) do |user|
        create(:user_profile, user: user)
      end
    end
  end
end