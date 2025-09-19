# features/step_definitions/homepage_steps.rb

Given('the app has featured stories available') do
  create_list(:story, 3, verified: true)
end

Then('I should see the site title {string}') do |title|
  expect(page).to have_title(title)
  expect(page).to have_content(title)
end

Then('I should see the main heading {string}') do |heading|
  expect(page).to have_css('h1', text: heading)
end

Then('I should see featured stories') do
  expect(page).to have_css('.featured-stories')
  expect(page).to have_css('.story-card', minimum: 1)
end

Then('I should see navigation options to join or sign in') do
  expect(page).to have_link('Join Community')
  expect(page).to have_link('Sign In')
end

Then('I should see {int} featured stories') do |count|
  expect(page).to have_css('.story-card', count: count)
end

Then('each story should display the author\'s location and age') do
  page.all('.story-card').each do |story_card|
    expect(story_card).to have_css('.author-info')
    expect(story_card.text).to match(/Age \d+/)
  end
end

Then('each story should have a verified badge') do
  page.all('.story-card').each do |story_card|
    expect(story_card).to have_css('.verified-badge')
  end
end