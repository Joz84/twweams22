module ChannelHelper
  def unread_channel_class(current_user, channel, sender_channel)
    if current_user.unread_messages_nbr(channel) == 0
      "id=unread-channel-#{channel.id}"
    elsif (channel == sender_channel) && (channel.messages.last == current_user.messages.last)
      ""
    else
      "class=unread"
    end
  end
end
