import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = [ "loading", "overlay" ]

  connect() {
    console.log("Hello, form loading controller!")
  }

  loading() {
    console.log("Loading...")
    this.loadingTarget.classList.remove("d-none")
    this.overlayTarget.classList.add("animate-overlay")
  }

}
