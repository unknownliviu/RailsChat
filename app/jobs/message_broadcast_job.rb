class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chat_rooms_#{message.chat_room.random_hash}_channel",
                                 message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.render partial: 'messages/message', locals: {message: message}
  end
end