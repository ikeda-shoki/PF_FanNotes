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
       @search_post_images = Kaminari.paginate_array(PostImage.preload(:user).where(['title LIKE ? OR image_introduction LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"])).page(params[:page]).per(8)
     end
   end
  end

  # post_image 並び替え
  def post_image_search
    session[:keyword] = params[:keyword]
    @selection = session[:keyword]
    @sort_post_images = Kaminari.paginate_array(PostImage.sort(@selection)).page(params[:page]).per(8)
    respond_to do |format|
      format.html { render 'post_images/index' }
      format.js
    end
  end

  # user 並び替え
  def user_search
    @selection = params[:keyword]
    @sort_users = Kaminari.paginate_array(User.sort(@selection)).page(params[:page]).per(4)
    render 'users/index'
  end

  def post_image_genre_search
    @post_images = PostImage.all.page(params[:page]).per(8)
    @selection = session[:keyword]
    sort_images = PostImage.sort(@selection)
    @genre = params[:genre]
    case @genre
    when "0" then
      @sort_post_images = Kaminari.paginate_array(sort_images).page(params[:page]).per(8)
    when "1" then
      @sort_post_images = Kaminari.paginate_array(sort_images.select { |n| n.post_image_genre === "イラスト"}).page(params[:page]).per(8)
    when "2" then
      @sort_post_images = Kaminari.paginate_array(sort_images.select { |n| n.post_image_genre === "写真"}).page(params[:page]).per(8)
    else
      @sort_post_images = Kaminari.paginate_array(sort_images.select { |n| n.post_image_genre === "ロゴ"}).page(params[:page]).per(8)
    end
    respond_to do |format|
      format.html { render 'post_images/index' }
      format.js
    end
  end
end
