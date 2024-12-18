import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    setTimeout(() => {this.#fitMapToMarkers()}, 1000)
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker, index) => {
      console.log(marker.lat, marker.lng, marker)

      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      const el = document.createElement('div')
      el.className = 'marker'

      console.log(marker.type, marker)
      console.log(marker.type === 'user')

      el.innerHTML = index + 1;
      if (marker.type === 'user') {
        el.className += 'user'
        new mapboxgl.Marker(el)
        .setLngLat([ marker.lon, marker.lat ])
        .addTo(this.map)
      } else {
        new mapboxgl.Marker(el)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
      }

    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker =>{
      if (marker.type === "activity") {bounds.extend([ marker.lng, marker.lat ])}
    })
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 2000 })
  }
}
