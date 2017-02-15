class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :load_chat_rooms

  private

  def load_chat_rooms
    @sidebar_chat_rooms = ChatRoom.for_user(current_user.id)#.where('user_id = ? or recipient_id = ?', current_user.id, current_user.id).uniq
  end
end
