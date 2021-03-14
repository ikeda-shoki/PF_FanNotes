class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def top
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.account_name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to main_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def new
    @post_image = PostImage.new
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_image_comment = PostImageComment.new
    @post_image_comments = @post_image.post_image_comments.order('created_at DESC')
    @user = @post_image.user
  end

  def index
    @post_images = PostImage.all
  end
  
  def main
    @post_images = PostImage.limit(10).order('id desc')
    @following_users = current_user.following_user if user_signed_in?
    @ranking_post_images = PostImage.find(Favorite.group(:post_image_id).order('count(post_image_id) desc').limit(10).pluck(:post_image_id))
  end

  def create
    @post_image = PostImage.new(post_image_params)
    if @post_image.save
      redirect_to main_path
    else
      render 'new'
    end
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image)
    else
      render 'edit'
    end
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    if @post_image.destroy
      redirect_to post_images_path
    else
      render 'edit'
    end
  end
  
  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @post_images = @tag.post_images
  end

  private
    def post_image_params
      params.require(:post_image).permit(:title, :image, :image_introduction, :user_id).merge(user_id: current_user.id)
    end
end
