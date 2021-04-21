class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def follow
    @user = User.find(params[:id])
    current_user.follow(params[:id])
    @user.create_notification_follow(current_user, @user)
    respond_to do |format|
      format.js { flash.now[:notice] = "#{@user.account_name}さんをフォローしました" }
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(params[:id])
    respond_to do |format|
      format.js { flash.now[:alert] = "#{@user.account_name}さんのフォローを外しました" }
    end
  end
end
