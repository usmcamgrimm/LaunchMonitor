import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["days", "hours", "minutes", "seconds"]
  
  connect() {
    this.initializeClock()
  }
  
  initializeClock() {
    const endDate = new Date(this.data.get("endTime"))
    const updateClock = () => {
      const t = this.getTimeRemaining(endDate)

      this.daysTarget.innerHTML = t.days
      this.hoursTarget.innerHTML = t.hours
      this.minutesTarget.innerHTML = t.minutes
      this.secondsTarget.innerHTML = t.seconds

      if (t.total <= 0) {
        clearInterval(timeInterval)
        this.daysTarget.innerHTML = '00'
        this.hoursTarget.innerHTML = '00'
        this.minutesTarget.innerHTML = '00'
        this.secondsTarget.innerHTML = '00'
      }
    }

    const timeInterval = setInterval(updateClock, 1000)
    updateClock() // Call once to initialize immediately
  }
  
  getTimeRemaining(endDate) {
    const total = Date.parse(endDate) - Date.parse(new Date())
    if (total <= 0) {
      return {
        total,
        days: '00',
        hours: '00',
        minutes: '00',
        seconds: '00'
      }
    }
    const seconds = String(Math.floor((total / 1000) % 60)).padStart(2, '0')
    const minutes = String(Math.floor((total / 1000 / 60) % 60)).padStart(2, '0')
    const hours = String(Math.floor((total / (1000 * 60 * 60)) % 24)).padStart(2, '0')
    const days = String(Math.floor(total / (1000 * 60 * 60 * 24))).padStart(2, '0')

    return {
      total,
      days,
      hours,
      minutes,
      seconds
    }
  }
}
