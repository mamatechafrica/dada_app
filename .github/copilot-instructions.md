# Dada App - GitHub Copilot Instructions

Dada App is a Ruby on Rails 8.0 application providing culturally-aware menopause support for African women and the diaspora. The application uses Devise for authentication, Bootstrap 5 for styling, and SQLite for the database in all environments.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Bootstrap, Build, and Test the Repository
**CRITICAL**: Follow these exact steps in order. Do NOT skip any steps.

```bash
# Install system dependencies (if needed)
sudo gem install bundler foreman

# Install Ruby dependencies
sudo bundle install  # Takes ~3 minutes, NEVER CANCEL. Use timeout 300+ seconds.

# Install Node.js dependencies  
npm install  # Takes ~10 seconds

# Build CSS assets
npm run build:css  # Takes ~3 seconds. Expect Sass deprecation warnings (these are normal)

# Setup database
bin/rails db:setup  # Takes ~2 seconds

# Run linting and security checks
bin/rubocop  # Takes ~2 seconds. Expect style violations in development
bin/brakeman --no-pager  # Takes ~3 seconds
bin/importmap audit  # Takes ~1 second
```

### Test the Application
```bash
# Run unit and integration tests
bin/rails test  # Takes ~17 seconds, NEVER CANCEL. Use timeout 60+ seconds.
# Note: Some tests may fail due to fixture issues - this is expected in development

# Run system tests (currently empty but framework exists)
bin/rails test:system  # Takes ~5 seconds
```

### Run the Development Server
```bash
# Start the development server (uses foreman)
bin/dev  # NEVER CANCEL. Server starts in ~2 seconds. Use timeout 120+ seconds for startup.
# This starts both:
# - Rails server on http://localhost:3000
# - Sass watcher for CSS compilation
```

### Manual Validation Scenarios
**ALWAYS test these complete user scenarios after making changes:**

1. **Homepage Load Test**: Navigate to http://localhost:3000 and verify the Dada homepage displays correctly with navigation, stories section, and AI chat interface.

2. **User Registration Flow**: 
   - Click "Join Community" → Fill registration form → Submit
   - Verify redirect to homepage with "Dashboard" and "Sign Out" in navigation
   - Confirm success message appears

3. **Onboarding Flow**:
   - Click "Dashboard" → Should redirect to onboarding
   - Fill out menopause stage, location, language, and preferences
   - Submit form (may error on routes - this is a known issue)

4. **Authentication State**: Verify navigation changes between logged-in and logged-out states.

## Repository Structure

### Key Directories
- `app/controllers/` - Main application controllers (ApplicationController, OnboardingController, DashboardController, HomeController)
- `app/models/` - Data models (User, UserProfile, Story) 
- `app/views/` - ERB templates organized by controller
- `app/assets/stylesheets/` - SCSS files, main file is application.scss
- `config/` - Rails configuration including routes.rb, database.yml
- `db/migrate/` - Database migrations for users, user profiles, and stories
- `test/` - Test files (unit, integration, system test structure exists)

### Important Files
- `Gemfile` - Ruby dependencies including Rails 8.0.2, Devise, Bootstrap
- `package.json` - Node.js dependencies (Bootstrap 5.3.7, Sass)
- `Procfile.dev` - Development server configuration (Rails + CSS watching)
- `.ruby-version` - Specifies Ruby 3.2.2
- `config/routes.rb` - Application routing
- `bin/setup` - Application setup script

## Technology Stack

- **Backend**: Ruby 3.2.2, Rails 8.0.2
- **Authentication**: Devise gem
- **Database**: SQLite3 (all environments)
- **Frontend**: Bootstrap 5.3.7, Stimulus, Turbo, ImportMaps
- **Styling**: Sass/SCSS compilation via Node.js
- **Testing**: Minitest (unit), Capybara (system)
- **Security**: Brakeman (static analysis), RuboCop (linting)

## Common Commands

### Development Workflow
```bash
# Make code changes, then always run:
bin/rubocop  # Fix style violations before committing
npm run build:css  # Rebuild CSS if you changed styles
bin/rails test  # Run tests to check for regressions

# Start development with live reloading:
bin/dev  # Starts Rails server + CSS watcher
```

### Database Operations
```bash
bin/rails db:migrate  # Run pending migrations
bin/rails db:seed     # Load seed data
bin/rails db:reset    # Reset database completely
bin/rails console    # Rails console for debugging
```

### Debugging
- **Server logs**: Check the terminal running `bin/dev`
- **Database**: Use `bin/rails console` and Active Record methods
- **CSS issues**: Check Sass compilation output in `bin/dev`
- **Routes**: Run `bin/rails routes` to see all available routes

## Dependencies and Environment

### Required Dependencies
- Ruby 3.2.2+ (specified in .ruby-version)
- Node.js and npm (for Sass compilation)
- SQLite3 (database)
- Bundler gem
- Foreman gem (for bin/dev)

### Permission Requirements
- **Critical**: Ruby gems require sudo installation (`sudo bundle install`, `sudo gem install`)
- Node.js packages install normally (`npm install`)

### Environment Variables
- `RAILS_ENV` - Set to development, test, or production
- `SECRET_KEY_BASE` - Rails secret (auto-generated in development)

## Validation Checklist

Before committing changes, ALWAYS run:
- [ ] `bin/rubocop` - Code style check
- [ ] `bin/brakeman --no-pager` - Security scan
- [ ] `bin/importmap audit` - JavaScript dependency security
- [ ] `npm run build:css` - CSS compilation test
- [ ] `bin/rails test` - Unit/integration tests
- [ ] Manual user flow test (registration → onboarding)

## Known Issues

1. **Bundler Permission Warnings**: Bundler warns about running as root, but `sudo bundle install` is required in this environment.
2. **Sass Deprecation Warnings**: Bootstrap 5.3.7 generates many Sass deprecation warnings - these are normal and expected.
3. **Test Failures**: Some tests fail due to fixture constraint issues - focus on testing your new code.
4. **Onboarding Route Error**: The onboarding update route has configuration issues - this is an existing application bug.
5. **CDN Resource Errors**: Browser console shows blocked CDN resources - these don't affect functionality.

## Development Tips

- **Always use absolute paths** when referencing repository files
- **Set appropriate timeouts** (60+ seconds) for bundle install and test commands
- **Test the complete user journey** after making changes, not just isolated features
- **Check both authenticated and non-authenticated states** when testing navigation changes
- **Use `bin/dev` for development** rather than `bin/rails server` to get CSS compilation
- **Monitor server logs** in the `bin/dev` terminal for debugging information

The application serves a meaningful purpose supporting African women through menopause with culturally-relevant guidance and community features.