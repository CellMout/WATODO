import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="doitbutton"
export default class extends Controller {
  static targets = ["link"]
  static values = { gmaps: String }

  connect() {
    console.log("Hello from doitbutton controller")
  }

  send(event) {
    event.preventDefault()
    console.log(this.linkTarget.href)
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    fetch(this.linkTarget.href, {
      method: "PATCH",
      headers: {
        'X-CSRF-Token': token,
      },
    })
      .then(response => response.text())
      .then((data) => {
        window.location.href = `https://www.google.com/maps/dir/?api=1&destination=${this.gmapsValue}&travelmode=walking`
      })

  }

}
