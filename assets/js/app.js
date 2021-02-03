// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import NProgress from "nprogress"
import {LiveSocket} from "phoenix_live_view"
import Player from '@vimeo/player';

let Hooks = {}
Hooks.InitToast = {
  mounted() {
    const toastEl = document.querySelector('.toast')
    if (toastEl.innerText !== '') {
      toastEl.classList.add("mr-4")

      setTimeout(() => {
        toastEl.classList.toggle("-mr-64", "mr-4")
      }, 3000);
    }
  }
}
Hooks.InitVideo = {
  mounted() {
      this.firstPlay = false
      console.log("MOUNTING")
      const player = new Player('video-player', {
        id: this.el.dataset.url,
        responsive: true
      });
      
      player.on('play', function() {
        if (!this.firstPlay) {
          this.firstPlay = true
          this.pushEvent("playback_started", {})
        }
      }.bind(this));
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: {_csrf_token: csrfToken},
  dom: {
    onBeforeElUpdated(from, to){
      if(from.__x){ window.Alpine.clone(from.__x, to) }
    }
  }
})


// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket


import 'alpinejs'