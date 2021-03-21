class SearchController < ApplicationController

  def search
   @user_or_image = params[:model]
   @search_word = params[:search]
   if @search_word.empty?
     if @user_or_image === "1"
       @search_users = []
     elsif @user_or_image === "2"
       @search_post_images = []
     end
   else
     if @user_or_image === "1"
       @search_users = Kaminari.paginate_array(User.where(['account_name LIKE ?', "%#{params[:search]}%"])).page(params[:page]).per(5)
     elsif @user_or_image === "2"
       @search_post_images = Kaminari.paginate_array(PostImage.where(['title LIKE ? OR image_introduction LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"])).page(params[:page]).per(8)
     end
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
    @sort_users = Kaminari.paginate_array(User.sort(@selection)).page(params[:page]).per(5)
    render 'users/index'
  end

end
