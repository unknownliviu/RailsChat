class ChatRoomsController < ApplicationController

  def index
    if params[:q]
      @chat_rooms = ChatRoom.for_user(current_user).where('title like ?', "%#{params[:q]}%")
    else
      @chat_rooms = ChatRoom.for_user(current_user)
    end
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(random_hash: params[:random_hash])
    @message = Message.new
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
