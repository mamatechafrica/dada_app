# spec/factories/user_profiles.rb

FactoryBot.define do
  factory :user_profile do
    association :user
    stage { "perimenopause" }
    symptoms { "Hot flashes, Night sweats, Mood changes" }
    preferences { "Natural remedies, Community support" }
    region { "Nigeria" }
    language { "English" }
    completed_onboarding { true }
    anonymous_name { "Sister Ocean" }

    trait :pre_menopause do
      stage { "pre-menopause" }
    end

    trait :menopause do
      stage { "menopause" }
    end

    trait :post_menopause do
      stage { "post-menopause" }
    end

    trait :incomplete_onboarding do
      completed_onboarding { false }
      stage { nil }
      symptoms { nil }
      preferences { nil }
    end
  end
end