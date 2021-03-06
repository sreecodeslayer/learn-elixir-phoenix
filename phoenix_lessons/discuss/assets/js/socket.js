// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
import { Socket } from 'phoenix'

let socket = new Socket('/socket', { params: { token: window.userToken } })
// Finally, connect to the socket:
socket.connect()

const createSocket = (topicID) => {
// Now that you are connected, you can join channels with a topic:
  let channel = socket.channel(`comments:${topicID}`, {})
  channel.join()
    .receive(
      'ok', resp => {
        renderComments(resp.comments)
      }
    )
    .receive('error', resp => { console.log('Unable to join', resp) })

  document.querySelector('button').addEventListener('click', () => {
    const comment = document.querySelector('textarea').value
    channel.push('comments:add', { text: comment })
  })

  channel.on(`comments:${topicID}:new`, renderComment)
}
const renderComment = (event) => {
  const renderedComment = commentTemplate(event.comment)
  document.querySelector('#comments').innerHTML += renderedComment
}
const renderComments = (comments) => {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment)
  })
  document.querySelector('#comments').innerHTML = renderedComments.join('')
}

const commentTemplate = (cmnt) => {
  return `<li class="collection-item">${cmnt.text}</li>`
}
window.createSocket = createSocket
