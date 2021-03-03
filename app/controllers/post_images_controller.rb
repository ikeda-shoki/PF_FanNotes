class PostImagesController < ApplicationController

  def top
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.account_name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to post_images_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def new
    @post_image = PostImage.new
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_image_comment = PostImageComment.new
    @post_image_comments = @post_image.post_image_comments
  end

  def index
    @post_images = PostImage.all
  end

  def create
    @post_image = PostImage.new(post_image_params)
    if @post_image.save
      redirect_to post_images_path
    else
      render 'new'
    end
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
