import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]
  static values = { index: Number }

  connect() {
    this.indexValue = this.containerTarget.children.length
  }

  addFacility(event) {
    event.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, this.indexValue)
    this.containerTarget.insertAdjacentHTML("beforeend", content)
    this.indexValue++
  }

  removeFacility(event) {
    event.preventDefault()

    const facilityItem = event.target.closest("[data-nested-form-target='item']")
    const destroyInput = facilityItem.querySelector("input[name*='_destroy']")

    if (destroyInput) {
      destroyInput.value = "1"
      facilityItem.style.display = "none"
    } else {
      facilityItem.remove()
    }
  }
}
