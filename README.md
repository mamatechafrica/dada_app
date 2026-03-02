# Dada App

A social sharing platform for women navigating menopause, built with Rails 8.0.

## 🚀 Roadmap

### Week 1: Segmentation ✅ Implemented
**Feature**: Onboarding + User Flags  
**User Emotion**: "Meet me where I am."

- User Story: As a woman just starting out, I want to say where I am in the journey so I don't feel overwhelmed.
- Journey Flow: Homepage → "Start Your Journey" → Answer: Menopause stage + symptoms + location → Get routed to a personalized landing page or content pack
- Status: Multi-step onboarding flow implemented at `/onboarding/step1-5`

### Week 2: Content 🔄 Partial
**Feature**: Bundles by Stage/Symptom  
**User Emotion**: "I feel seen."

- User Story: As someone struggling with hot flashes, I want content rooted in African voices so I know I'm not alone.
- Journey Flow: After onboarding, user lands on a content bundle (Story, Video, CTA)
- Status: ✅ Comfy CMS installed with Redactor WYSIWYG editor at `/admin`

### Week 3: Community ⏳ Not Started
**Feature**: DADA Circles (Forums via Thredded)  
**User Emotion**: "I feel heard."

- User Story: As someone feeling isolated, I want to connect with others like me in a safe, anonymous way.
- Journey Flow: Click "Join the Conversation" → Land in a Circle (forum) → Post as pseudonym → React to others
- Status: Circle model exists, needs Thredded forum integration

### Week 4: Retention ⏳ Not Started
**Feature**: Weekly Nudges (Email + In-App)  
**User Emotion**: "Thanks for checking in."

- User Story: As a busy woman, I want gentle check-ins to remind me I'm not alone.
- Journey Flow: Opt-in to email nudges → Weekly message → Links to bundles, Circles
- Status: Needs email/notification system implementation

### Week 5: Mobile ⏳ Not Started
**Feature**: Turbo Hotwire Native  
**User Emotion**: "It fits my life."

- User Story: As someone with limited internet, I want to use DADA like an app.
- Journey Flow: Open DADA on iOS/Android → prompted to install → Works offline
- Status: Needs PWA/offline capabilities

---

## Current Features

### Implemented
- User Authentication (Devise) - sign up, sign in, password management
- Multi-step onboarding flow (5 steps)
- Shares - create text, image, or video content
- Circles - browse community circles
- Content browsing (shares index/show)
- User profiles
- AI Chatbot integration placeholder
- Dark mode support
- Responsive design with Tailwind CSS v4
- Password visibility toggle on all forms

### Tech Stack
- **Framework**: Rails 8.0
- **Database**: SQLite3
- **Styling**: Tailwind CSS v4
- **Authentication**: Devise
- **JavaScript**: Hotwire (Turbo + Stimulus)
- **Asset Pipeline**: Propshaft
- **AI**: Ruby LLM gem (placeholder)

---

## Setup

```bash
# Install dependencies
bundle install

# Set up the database
rails db:create db:migrate

# Build Tailwind CSS
rails tailwindcss:build

# Start the development server
rails s
```

## Development

```bash
# Run the dev server with hot reload
bin/dev

# Run tests
rails test

# Run brakeman security scan
brakeman
```

## Routes

| Path | Controller#Action |
|------|-------------------|
| `/` | `home#index` |
| `/users/sign_up` | `devise/registrations#new` |
| `/users/sign_in` | `devise/sessions#new` |
| `/profile` | `web/profiles#show` |
| `/web/circles` | `web/circles#index` |
| `/web/circles/:id` | `web/circles#show` |
| `/web/shares` | `web/shares#index` |
| `/web/shares/new` | `web/shares#new` |
| `/web/shares/:id` | `web/shares#show` |
| `/web/contents` | `web/contents#index` |
| `/web/chatbot` | `web/chatbot#index` |
| `/onboarding/step1-5` | `web/onboarding#step1-5` |

## Custom Colors

The app uses custom Dada brand colors:

- Primary: `#E84D4D`
- Secondary: `#FFB6A9`
- Text: `#5E2A35`
- Background: `#FFF5F3`

## Deployment

The app is configured for deployment with Kamal. See `config/deploy.yml` for configuration.
