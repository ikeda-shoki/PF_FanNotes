class PostImagesController < ApplicationController
  
  def top
  end
  
  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.account_name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def new
    @post_image = PostImage.new
  end
  
  def show
  end
  
  def index
    @post_images = PostImage.all
  end
  
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.save
    redirect_to post_images_path
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
    def post_image_params
      params.require(:post_image).permit(:title, :image, :image_introduction, :user_id).merge(user_id: current_user.id)
    end
  
end
