class MessagesController < ApplicationController
  before_action :find_channel, only: [:create, :destroy]

  def create
    @message = Message.new( user: current_user,
                            channel: @channel,
                            content: message_params[:content]
                          )

    if @message.save
      ActionCable.server.broadcast "room_channel_#{@channel.id}",
                                    channel_id: @channel.id,
                                    message_id: @message.id,
                                    content: @message.content,
                                    msg_date: @message.updated_at.strftime("%d/%m/%y à %Hh%M"),
                                    alias: current_user.alias,
                                    user_id: current_user.id,
                                    image_link: ((@message.content[0..6] == "http://") || (@message.content[0..7] == "https://")) ? ("<a href='"+@message.content+"'> See picture website </a>").html_safe : @message.content,
                                    image_preview: @message.iframely_preview

      ActionCable.server.broadcast "notification_channel",
                                    content: @message.content,
                                    channel_id: @channel.id,
                                    last_message_user_id: Message.last.user.id

    end
  end

  #     redirect_to @channel
  #   else
  #     @messages = @channel.messages
  #     @channels = current_user.channels
  #     render 'channels/show'
  #   end
  # end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to @channel
  end

  private

  def find_channel
    @channel = Channel.find(params[:channel_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
