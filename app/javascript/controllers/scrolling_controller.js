import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scrolling"
export default class extends Controller {
  static targets = ["page"];

  connect() {
    console.log("Hello from scrolling_controller.js")
  }

  scrollToTop() {
    console.log("scrolling to top");
    this.pageTarget.scrollIntoView({ block: "start" });
  }

  scrollToBottom() {
    console.log("scrolling to bottom");
    this.pageTarget.scrollIntoView({ block: "end" });
  }
}
