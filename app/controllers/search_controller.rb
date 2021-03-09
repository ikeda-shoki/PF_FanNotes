class SearchController < ApplicationController

  def search
   @user_or_image = params[:model]
    if @user_or_image === "1"
      @search_users = User.where(['account_name LIKE ?', "%#{params[:search]}%"])
    elsif @user_or_image === "2"
      @search_post_images = PostImage.where(['title LIKE ? OR image_introduction LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"])
    end
  end
  
  def post_image_search
    @selection = params[:keyword]
    @sort_post_images = PostImage.sort(@selection)
    render 'post_images/index'
  end

end
