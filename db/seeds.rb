# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create sample stories
stories_data = [
  {
    title: "Finding sisterhood through Dada changed everything",
    content: "I learned that my night sweats weren't just 'getting older' but a normal part of menopause that I could manage naturally. The community here helped me understand my body and find natural remedies that work.",
    author_name: "Amara K.",
    author_location: "Lagos, Nigeria",
    author_age: 52,
    stage: "post-menopause",
    tags: "Night Sweats, Natural Remedies, Community",
    verified: true,
    region: "Nigeria"
  },
  {
    title: "AI chat helped me understand my journey",
    content: "The AI chat helped me understand my irregular periods weren't something to worry about alone. Now I have strategies that fit my lifestyle and cultural practices. It's like having a wise auntie available 24/7.",
    author_name: "Grace M.",
    author_location: "Nairobi, Kenya",
    author_age: 48,
    stage: "perimenopause",
    tags: "Irregular Periods, Cultural Practices, AI Support",
    verified: true,
    region: "Kenya"
  },
  {
    title: "Preparing my daughters for their journey",
    content: "As a grandmother, I want to prepare my daughters. Dada gave me the language and knowledge to start these important conversations in our family. Knowledge is power, and our daughters deserve this power.",
    author_name: "Fatou S.",
    author_location: "Accra, Ghana",
    author_age: 55,
    stage: "post-menopause",
    tags: "Family Conversations, Intergenerational, Education",
    verified: true,
    region: "Ghana"
  },
  {
    title: "No more suffering in silence",
    content: "I used to think the mood changes and fatigue were just stress. Dada helped me understand these are normal perimenopause symptoms. Now I have coping strategies that honor both modern and traditional approaches.",
    author_name: "Zara T.",
    author_location: "Johannesburg, South Africa",
    author_age: 46,
    stage: "perimenopause",
    tags: "Mood Changes, Fatigue, Traditional Medicine",
    verified: true,
    region: "South Africa"
  },
  {
    title: "Cultural healing and modern medicine together",
    content: "Dada helped me bridge the gap between what my grandmother taught me and what doctors say. I'm using both traditional herbs and modern treatments, and I feel so much more balanced.",
    author_name: "Kemi A.",
    author_location: "Ibadan, Nigeria",
    author_age: 50,
    stage: "menopause",
    tags: "Traditional Healing, Modern Medicine, Balance",
    verified: true,
    region: "Nigeria"
  }
]

stories_data.each do |story_attrs|
  Story.find_or_create_by(title: story_attrs[:title]) do |story|
    story.assign_attributes(story_attrs)
  end
end

puts "Created #{Story.count} stories"
