import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  reset(event) {
    event.preventDefault()
    this.checkboxTargets.forEach(cb => cb.checked = false)
  }
}
