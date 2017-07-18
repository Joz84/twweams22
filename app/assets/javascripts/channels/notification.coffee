App.room = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('Notification Channel connected to the server')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('Notification Channel disconnected from the server')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.content.blank?
      current_user_id = $('#current_user_id').text()
      unread_messages_nbr = $('.badge-blue').text()
      tab = gon.tab
      c = parseInt(data.channel_id)
      d = parseInt(current_user_id)
      e = parseInt(unread_messages_nbr)
      f = parseInt(data.last_message_user_id)

      if f isnt d
        if c in tab
          e = e+1
          $('#notification-'+d).removeClass('hidden')
          $('#notification-'+d).html(e)
        $('#unread-channel-'+data.channel_id).addClass('unread')
