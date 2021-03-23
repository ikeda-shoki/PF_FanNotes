class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.new(post_image_id: @post_image.id)
    favorite.save
    @post_image.create_notification_favorite(current_user)
    respond_to do |format|
      format.js { flash.now[:notice] = "いいねを送信しました" }
    end
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: @post_image.id)
    favorite.destroy
    respond_to do |format|
      format.js { flash.now[:alert] = "いいねを取り消しました" }
    end
  end
end
