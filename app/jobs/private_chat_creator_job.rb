class PrivateChatCreatorJob < ApplicationJob
  queue_as :default

  def perform(user)
    other_users = User.where('id != ?', user.id)
    other_users.each {|u| create_chatroom_for(u, user)}
  end

  private

  def create_chatroom_for(recipient, creator)
    ChatRoom.create(title: "#{recipient.name} - #{creator.name}", user: creator, recipient: recipient)
  end
end