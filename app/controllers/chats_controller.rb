class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms
    request_room = rooms.find_by(room_id: params[:request_id])
    unless request_room.nil?
      user_room = UserRoom.find_by(user_id: @user.id, room_id: request_room.room_id)
      @room = user_room.room
    else
      @room = Room.create(request_id: params[:request_id])
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    room = Room.find_by(id: @chat.room_id)
    @chats = room.chats
    if @chat.save
      @chat.create_notification_chat(current_user)
    else
      render 'error'
    end
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    room = @chat.room
    @chats = room.chats
    @chat.destroy
  end
  
  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
