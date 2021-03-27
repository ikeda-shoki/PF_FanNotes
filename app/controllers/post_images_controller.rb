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
    @post_images = PostImage.all.page(params[:page]).per(8)
    # 並び替え機能はsearch_controller, post_image.rbに記載
  end

  def main
    @post_images = PostImage.limit(10).order('id desc')
    @following_users_post_images = PostImage.where(user_id: current_user.following_user.pluck(:id)).limit(15).order('id desc')
    @ranking_post_images = PostImage.find(Favorite.group(:post_image_id).order(Arel.sql('count(post_image_id) desc')).limit(10).pluck(:post_image_id))
    @hashtags = Hashtag.find(PostImageHashtagRelation.group(:hashtag_id).order(Arel.sql('count(hashtag_id) desc')).limit(20).pluck(:hashtag_id))
  end

  def create
    @post_image = PostImage.new(post_image_params)
    if @post_image.save
      redirect_to user_path(current_user), notice: '投稿に成功しました'
    else
      render 'new'
    end
    #post_imageモデルでafter_createを使用して＃を追加する
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def update
    @post_image = PostImage.find(params[:id])
    #post_imageモデルでbefore_updateを使用して＃を1から追加する
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image), notice: '投稿を更新しました'
    else
      render 'edit'
    end
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    if @post_image.destroy
      redirect_to user_path(current_user), alert: '投稿を削除しました'
    else
      render 'edit'
    end
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @post_images = @tag.post_images.page(params[:page]).per(8)
  end

  private
    def post_image_params
      params.require(:post_image).permit(:title, :image, :image_introduction, :user_id).merge(user_id: current_user.id)
    end
end
