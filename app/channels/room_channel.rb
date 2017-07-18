class RoomChannel < ApplicationCable::Channel
  def subscribed
    # current_channel comes from connection.rb
    stream_from "room_channel_#{current_channel.id}"

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
