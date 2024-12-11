import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-coordinates"
export default class extends Controller {
  static targets = ["latitude", "longitude"]

  connect() {
    console.log("Hello from user-coordinates controller")

    // Get the user's current location
    navigator.geolocation.getCurrentPosition((position) => {
      console.log(position.coords.latitude, position.coords.longitude)
      this.latitudeTarget.value = position.coords.latitude
      this.longitudeTarget.value = position.coords.longitude
    })
  }
}
