import { Socket, Presence } from "phoenix"

function guid() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
      .toString(16)
      .substring(1);
  }
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
}

let socket = new Socket("/socket", { params: { token: window.userToken } })

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("turtle_watch:thadeous", { uuid: guid() });
let presence = new Presence(channel);
let listBy = (id, { metas: [first, ...rest] }) => {
  first.count = rest.length + 1 // count of this user's presences
  first.id = id
  return first
}

presence.onSync(() => {
  let usersElem = document.getElementById("numUsers");
  let presences = presence.list(listBy);
  usersElem.innerHTML = presences.length;
})

channel.on("stream", payload => {
  console.log("stream")
  let img = document.getElementById("img");
  img.src = "data:image/jpg;base64," + payload.image;
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

export default socket
