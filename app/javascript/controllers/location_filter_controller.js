import {Controller }  from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  reset(event) {
    event.preventDefault()
    console.log("Reset clicked!")
    this.checkboxTargets.forEach(checkbox => {
      checkbox.checked = false
    })
  }
}