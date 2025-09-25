import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  static targets = ["modal", "step", "nextBtn", "prevBtn", "progressBar", "stepCounter", "locationInput", "personalizedMessage"]
  static values = { currentStep: Number }

  connect() {
    this.currentStepValue = 1
    this.totalSteps = 5
    this.formData = {}
    this.modal = null
  }

  // Open the modal - Updated to specify the .js format
  async open(event) {
    event.preventDefault()
    
    try {
      // Fetch the initial onboarding step with explicit JavaScript format
      const response = await fetch('/onboarding/start.js?step=location', {
        method: 'GET',
        headers: {
          'Accept': 'text/javascript', // Specify JavaScript format
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      
      if (response.ok) {
        const script = await response.text()
        // Execute the JavaScript response
        eval(script)
      } else {
        console.error('Failed to load onboarding modal')
        this.showFallbackForm()
      }
    } catch (error) {
      console.error('Error opening onboarding modal:', error)
      this.showFallbackForm()
    }
  }

  showFallbackForm() {
    // Show the fallback form if AJAX fails
    const fallbackForm = document.getElementById('fallback-form')
    const heroSection = document.querySelector('.onboarding-hero')
    
    if (fallbackForm && heroSection) {
      fallbackForm.classList.remove('d-none')
      heroSection.style.display = 'none'
    }
  }

  // Navigate to next step
  next() {
    if (this.currentStepValue < this.totalSteps) {
      this.currentStepValue++
      this.updateDisplay()
    }
  }

  // Navigate to previous step
  previous() {
    if (this.currentStepValue > 1) {
      this.currentStepValue--
      this.updateDisplay()
    }
  }

  // Skip to next step (for symptoms step)
  skip() {
    if (this.currentStepValue === 3) { // Symptoms step (welcome=1, stage=2, symptoms=3)
      this.next()
    }
  }

  // Complete onboarding
  complete() {
    // Collect all form data
    this.collectFormData()
    
    // Send data to server
    this.submitOnboarding()
    
    // Hide the modal
    const modal = bootstrap.Modal.getInstance(document.getElementById('onboardingModal'))
    modal.hide()
    
    // Show success message or redirect to dashboard
    this.showCompletionMessage()
  }

  // Collect form data from all steps
  collectFormData() {
    // Get menopause stage
    const stageRadio = document.querySelector('input[name="menopause_stage"]:checked')
    if (stageRadio) {
      this.formData.stage = stageRadio.value
    }

    // Get symptoms
    const symptomCheckboxes = document.querySelectorAll('input[name="symptoms[]"]:checked')
    this.formData.symptoms = Array.from(symptomCheckboxes).map(cb => cb.value).join(', ')

    // Get location
    const locationInput = this.hasLocationInputTarget ? this.locationInputTarget.value : ''
    this.formData.location = locationInput
  }

  // Submit onboarding data to server
  async submitOnboarding() {
    try {
      // If user is authenticated, send to onboarding endpoint
      // If not authenticated, store in localStorage for later
      if (document.querySelector('meta[name="current-user"]')) {
        await this.submitToServer()
      } else {
        this.storeForLater()
      }
    } catch (error) {
      console.error('Error submitting onboarding:', error)
    }
  }

  async submitToServer() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')
    
    const response = await fetch('/onboarding', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({
        user_profile: {
          stage: this.formData.stage,
          symptoms: this.formData.symptoms,
          region: this.formData.location
        }
      })
    })

    if (!response.ok) {
      throw new Error('Failed to submit onboarding data')
    }
  }

  storeForLater() {
    localStorage.setItem('dada_onboarding', JSON.stringify(this.formData))
  }

  // Update the display based on current step
  updateDisplay() {
    // Hide all steps
    this.stepTargets.forEach((step, index) => {
      step.classList.toggle("d-none", index !== this.currentStepValue - 1)
    })

    // Update progress bar
    const progress = (this.currentStepValue / this.totalSteps) * 100
    if (this.hasProgressBarTarget) {
      this.progressBarTarget.style.width = `${progress}%`
      this.progressBarTarget.setAttribute("aria-valuenow", progress)
    }

    // Update step counter
    if (this.hasStepCounterTarget) {
      this.stepCounterTarget.textContent = `${this.currentStepValue} of ${this.totalSteps}`
    }

    // Update button states
    if (this.hasPrevBtnTarget) {
      this.prevBtnTarget.disabled = this.currentStepValue === 1
      
      // Hide previous button on welcome step
      if (this.currentStepValue === 1) {
        this.prevBtnTarget.style.visibility = 'hidden'
      } else {
        this.prevBtnTarget.style.visibility = 'visible'
      }
    }
    
    if (this.hasNextBtnTarget) {
      // Update next button text and style based on step
      if (this.currentStepValue === 1) {
        this.nextBtnTarget.style.display = 'none' // Hidden on welcome step
      } else if (this.currentStepValue === this.totalSteps) {
        this.nextBtnTarget.textContent = "Start Exploring"
        this.nextBtnTarget.classList.remove("btn-primary")
        this.nextBtnTarget.classList.add("btn-success")
        this.nextBtnTarget.style.display = 'block'
      } else if (this.currentStepValue === 4) { // Location step
        this.nextBtnTarget.textContent = "See My Results"
        this.nextBtnTarget.classList.remove("btn-success")
        this.nextBtnTarget.classList.add("btn-primary")
        this.nextBtnTarget.style.display = 'block'
      } else {
        this.nextBtnTarget.textContent = "Next"
        this.nextBtnTarget.classList.remove("btn-success")
        this.nextBtnTarget.classList.add("btn-primary")
        this.nextBtnTarget.style.display = 'block'
      }
    }

    // Update personalized message on final step
    if (this.currentStepValue === this.totalSteps && this.hasPersonalizedMessageTarget) {
      this.updatePersonalizedMessage()
    }
  }

  // Update personalized message based on collected data
  updatePersonalizedMessage() {
    let message = "You're navigating your unique journey, and we see you."
    
    const stageRadio = document.querySelector('input[name="menopause_stage"]:checked')
    const selectedSymptoms = document.querySelectorAll('input[name="symptoms[]"]:checked')
    
    if (stageRadio) {
      const stageText = this.getStageDisplayText(stageRadio.value)
      message = `You're navigating ${stageText}, and we see you.`
      
      if (selectedSymptoms.length > 0) {
        const symptomsList = Array.from(selectedSymptoms)
          .slice(0, 2) // Show first 2 symptoms
          .map(cb => this.getSymptomDisplayText(cb.value))
          .join(' and ')
        
        message += ` Here's content and community made for women managing ${symptomsList}.`
      } else {
        message += ` Here's content and community made for women just like you.`
      }
    }
    
    this.personalizedMessageTarget.textContent = message
  }

  getStageDisplayText(stage) {
    const stageMap = {
      'perimenopause': 'perimenopause',
      'menopause': 'menopause',
      'post-menopause': 'post-menopause',
      'exploring': 'this journey of discovery'
    }
    return stageMap[stage] || 'your unique journey'
  }

  getSymptomDisplayText(symptom) {
    const symptomMap = {
      'hot_flashes': 'hot flashes',
      'trouble_sleeping': 'sleep troubles',
      'mood_changes': 'mood changes',
      'anxiety': 'anxiety',
      'brain_fog': 'brain fog',
      'irregular_periods': 'irregular periods',
      'vaginal_dryness': 'vaginal dryness',
      'low_libido': 'low libido',
      'weight_changes': 'weight changes'
    }
    return symptomMap[symptom] || symptom
  }

  // Handle next/complete button click
  handleNext() {
    if (this.currentStepValue === this.totalSteps) {
      this.complete()
    } else {
      this.next()
    }
  }

  // Show completion message
  showCompletionMessage() {
    // Redirect to dashboard if user is logged in, otherwise prompt for sign up
    if (document.querySelector('meta[name="current-user"]')) {
      window.location.href = '/dashboard'
    } else {
      // Could show a sign-up modal or redirect to registration
      alert("Welcome to your menopause journey! Sign up to save your preferences and get personalized content.")
    }
  }
}