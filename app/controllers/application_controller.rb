class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :load_chat_rooms

  private

  def load_chat_rooms
    @chat_rooms = ChatRoom.all
  end
end
