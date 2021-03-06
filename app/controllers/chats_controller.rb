class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_request_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @request = Request.find(params[:request_id])
    rooms = current_user.user_rooms
    request_room = rooms.find_by(room_id: params[:request_id])
    if request_room.nil?
      @room = Room.create(id: params[:request_id], request_id: params[:request_id])
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      user_room = UserRoom.find_by(user_id: @user.id, room_id: request_room.room_id)
      @room = user_room.room
    end
    @chats = @room.chats.preload(:user)
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
    respond_to do |format|
      format.js { flash.now[:alert] = "対象のコメントを削除しました" }
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def ensure_request_user
    @request = Request.find(params[:request_id])
    if current_user != @request.requester && current_user != @request.requested
      redirect_to main_post_images_path, alert: "メッセージ画面はリクエストユーザー同士以外は閲覧することはできません"
    end
  end
end
