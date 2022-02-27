//import "chart.js"
import {CategoryScale, Chart, LinearScale, LineController, LineElement, PointElement} from 'chart.js';
import "leaflet"

Chart.register(LinearScale, LineController, CategoryScale, LineElement, PointElement);

window.drawChart = function (id, label, labels, data, color) {
    const context = document.getElementById(id).getContext('2d');
    const chart = new Chart(context, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: label,
                data: data,
                borderColor: color
            }]
        },
        options: {
            responsive: false,
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            elements: {
                point: {
                    radius: 0
                }
            },
        }
    });
}

window.addMap = function(
  gpsTrackPositions,
  iconUrl,
  shadowUrl
) {
  var myIcon = L.icon({
    iconUrl: iconUrl,
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    shadowUrl: shadowUrl,
    shadowSize: [41, 41],
    shadowAnchor: [12, 41]
  });
  const map = L.map('map');
  const tileLayer = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  });
  tileLayer.addTo(map);

  const gpsTrack = L.polyline(gpsTrackPositions, {
    color: 'red',
  });
  let marker = L.marker([0, 0], {icon: myIcon});
  gpsTrack.on('mouseover', e => {
    marker.setLatLng(e.latlng);
    if (!map.hasLayer(marker)) {
      marker.addTo(map);
    }
  });
  gpsTrack.on('mouseout', e => {
    marker.removeFrom(map);
  });
  gpsTrack.addTo(map);
  map.fitBounds(gpsTrack.getBounds());
}
