import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "arrow"]

  connect() {
    if (this.hasContentTarget) {
      this.contentTarget.classList.add('hidden')
    }
  }

  toggle(event) {
    event.preventDefault()
    
    if (this.hasContentTarget) {
      this.contentTarget.classList.toggle('hidden')

      if (this.hasArrowTarget) {
        this.arrowTarget.classList.toggle('rotate-180')
      }
    }
  }
}