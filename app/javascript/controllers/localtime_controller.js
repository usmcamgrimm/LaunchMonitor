import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const iso = this.element.getAttribute("datetime")
    const date = new Date(iso)

    if (date) {
      const launchDate = date.toLocaleString(undefined, {
        weekday: "short", month: "short", day: "numeric",
      })

      const launchTime = date.toLocaleString(undefined, {
        hour: "numeric", minute: "2-digit"
      })

    this.element.textContent = `${launchDate} - ${launchTime}`
    }
  }
}