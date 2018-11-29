import { Socket } from "phoenix"
var pako = require('pako');
var enc = new TextEncoder();
var dec = new TextDecoder("utf-8");
window["pako"] = pako;

let socket = new Socket("/socket", { params: { token: window.userToken } })

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("turtle_watch:*", {})

channel.on("stream", payload => {
  console.log("stream")
  var img = document.getElementById("img");
  img.src = "data:image/jpg;base64," + payload.image;
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

export default socket
