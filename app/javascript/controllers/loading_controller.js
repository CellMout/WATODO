import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = [ "loading" ]

  connect() {
    console.log("Hello, form loading controller!")
  }

  loading() {
    console.log("Loading...")
    this.loadingTarget.classList.remove("d-none")
  }

}
