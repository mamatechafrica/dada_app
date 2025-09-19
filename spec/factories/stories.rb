# spec/factories/stories.rb

FactoryBot.define do
  factory :story do
    sequence(:title) { |n| "Inspiring Story #{n}" }
    content { "This is a beautiful story about the menopause journey and finding community support through cultural wisdom and modern understanding." }
    author_name { "Amara K." }
    author_location { "Lagos, Nigeria" }
    author_age { 52 }
    stage { "post-menopause" }
    tags { "Community, Support, Natural Remedies" }
    verified { true }
    region { "Nigeria" }

    trait :unverified do
      verified { false }
    end

    trait :perimenopause_story do
      stage { "perimenopause" }
      author_age { 48 }
    end

    trait :kenyan_story do
      author_location { "Nairobi, Kenya" }
      region { "Kenya" }
    end

    trait :south_african_story do
      author_location { "Johannesburg, South Africa" }
      region { "South Africa" }
    end
  end
end