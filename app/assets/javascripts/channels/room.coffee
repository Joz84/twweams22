App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('Room Channel connected to the server')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('Room Channel disconnected from the server')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.content.blank?
      current_user_id = $('#current_user_id').text()
      a = data.user_id
      b = parseInt(current_user_id)
      x = data.image_preview
      if x is null
        x = " "
      $('#messages-table').append '<li id="message-container"><div id="message-infos"><h3>' + data.alias + '</h3> <p> | '+ data.msg_date+'</p></div>
      <div class="content">' +data.image_link+ '</div> <div class="iframe">' +x+ '</div></li>'
      if a is b
        $('#messages-table').append "<div id='delete-btn'><a data-confirm='Are you sure! Do you want delete this post' rel='nofollow' data-method='delete' href='/channels/"+data.channel_id+"/messages/"+data.message_id+"'>delete</a>"
      scroll_bottom()

$(document).ready ->
  submit_message()
  scroll_bottom()

submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13 && !event.shiftKey
      $('input').click()
      event.target.value = ""
      event.preventDefault()

scroll_bottom = () ->
  $('html, body').animate { scrollTop: $('html, body').get(0).scrollHeight }, 1000
  return
