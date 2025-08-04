import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "step", "nextBtn", "prevBtn", "progressBar", "stepCounter"]
  static values = { currentStep: Number }

  connect() {
    this.currentStepValue = 1
    this.totalSteps = 6
    this.updateDisplay()
  }

  // Open the modal
  open() {
    const modal = new bootstrap.Modal(this.modalTarget)
    modal.show()
    this.currentStepValue = 1
    this.updateDisplay()
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

  // Skip to final step
  skip() {
    this.currentStepValue = this.totalSteps
    this.updateDisplay()
  }

  // Complete onboarding
  complete() {
    // Hide the modal
    const modal = bootstrap.Modal.getInstance(this.modalTarget)
    modal.hide()
    
    // Show success message or redirect
    this.showCompletionMessage()
  }

  // Update the display based on current step
  updateDisplay() {
    // Hide all steps
    this.stepTargets.forEach((step, index) => {
      step.classList.toggle("d-none", index !== this.currentStepValue - 1)
    })

    // Update progress bar
    const progress = (this.currentStepValue / this.totalSteps) * 100
    this.progressBarTarget.style.width = `${progress}%`
    this.progressBarTarget.setAttribute("aria-valuenow", progress)

    // Update step counter
    this.stepCounterTarget.textContent = `${this.currentStepValue} of ${this.totalSteps}`

    // Update button states
    this.prevBtnTarget.disabled = this.currentStepValue === 1
    
    // Update next button text for final step
    if (this.currentStepValue === this.totalSteps) {
      this.nextBtnTarget.textContent = "Complete Journey"
      this.nextBtnTarget.classList.remove("btn-primary")
      this.nextBtnTarget.classList.add("btn-success")
    } else {
      this.nextBtnTarget.textContent = "Next"
      this.nextBtnTarget.classList.remove("btn-success")
      this.nextBtnTarget.classList.add("btn-primary")
    }
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
    // You can customize this to show a toast, redirect, or other action
    alert("Welcome to your menopause journey! Your personalized experience awaits.")
  }
}