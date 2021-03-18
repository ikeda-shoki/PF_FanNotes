class SearchController < ApplicationController

  def search
   @user_or_image = params[:model]
    if @user_or_image === "1"
      @search_users = User.where(['account_name LIKE ?', "%#{params[:search]}%"])
    elsif @user_or_image === "2"
      @search_post_images = PostImage.where(['title LIKE ? OR image_introduction LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"])
    end
  end
  
  # post_image 並び替え
  def post_image_search
    @selection = params[:keyword]
    @sort_post_images = Kaminari.paginate_array(PostImage.sort(@selection)).page(params[:page]).per(8)
    render 'post_images/index'
  end
  
  # user 並び替え
  def user_search
    @selection = params[:keyword]
    @sort_users = User.sort(@selection)
    render 'users/index'
  end

end
