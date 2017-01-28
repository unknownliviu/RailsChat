class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], chat_room: ChatRoom.find_by(random_hash: data['chat_room_id']))
  end
end
