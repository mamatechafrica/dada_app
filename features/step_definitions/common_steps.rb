# features/step_definitions/common_steps.rb

# Navigation steps
When('I visit the homepage') do
  visit root_path
end

When('I visit the dashboard') do
  visit dashboard_path
end

When('I visit the onboarding page') do
  visit onboarding_path
end

# Clicking and form interaction steps
When('I click {string}') do |text|
  click_link_or_button text
end

When('I submit the registration form') do
  click_button 'Sign up'
end

When('I submit the onboarding form') do
  click_button 'Complete Profile'
end

# Assertion steps
Then('I should see {string}') do |text|
  expect(page).to have_content(text)
end

Then('I should be on the user registration page') do
  expect(current_path).to eq(new_user_registration_path)
end

Then('I should be on the user sign in page') do
  expect(current_path).to eq(new_user_session_path)
end

Then('I should remain on the registration page') do
  expect(current_path).to eq(user_registration_path)
end

Then('I should be redirected to the onboarding page') do
  expect(current_path).to eq(onboarding_path)
end

Then('I should be redirected to the dashboard') do
  expect(current_path).to eq(dashboard_path)
end

# Error message steps
Then('I should see an error message about the email format') do
  expect(page).to have_content('Email is invalid')
end

Then('I should see an error message about password confirmation') do
  expect(page).to have_content("Password confirmation doesn't match")
end

Then('I should see an error message about email already being taken') do
  expect(page).to have_content('Email has already been taken')
end

Then('I should see a validation error') do
  expect(page).to have_content('Stage can\'t be blank')
end