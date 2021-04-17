class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_post_image, only: [:show, :edit, :update, :destroy]

  def get_post_image
    @post_image = PostImage.find(params[:id])
  end

  def top
  end

  def new
    @post_image = PostImage.new
  end

  def show
    @post_image_comment = PostImageComment.new
    @post_image_comments = Kaminari.paginate_array(@post_image.get_post_image_comment).page(params[:page]).per(10)
    @user = @post_image.user
  end

  def index
    @post_images = PostImage.preload(:user).all.page(params[:page]).per(8)
    # 並び替え機能はsearch_controller, post_image.rbに記載
  end

  def main
    @post_images = PostImage.preload(:user).sort_new(10)
    @following_users_post_images = PostImage.preload(:user).my_follower_img(current_user).sort_new(15) if user_signed_in?
    @hashtags = Hashtag.find(PostImageHashtagRelation.group(:hashtag_id).sort_favorite(:hashtag_id, 20).pluck(:hashtag_id))
    ranking_post_images = PostImage.preload(:user).find(Favorite.group(:post_image_id).sort_favorite(:post_image_id))
    @ranking_post_images = ranking_post_images.first(10)
    @post_images_illust = (ranking_post_images.select { |n| n.post_image_genre === "イラスト" }).first(10)
    @post_images_photo = (ranking_post_images.select { |n| n.post_image_genre === "写真" }).first(10)
    @post_images_logo = (ranking_post_images.select { |n| n.post_image_genre === "ロゴ" }).first(10)
  end

  def create
    @post_image = PostImage.new(post_image_params)
    if @post_image.save
      redirect_to user_path(current_user), notice: '投稿に成功しました'
    else
      render 'new'
    end
    # post_image.rbでafter_createを使用して＃を追加する
  end

  def edit
  end

  def update
    # post_image.rbでbefore_updateを使用して＃を1から追加する
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image), notice: '投稿を更新しました'
    else
      render 'edit'
    end
  end

  def destroy
    if @post_image.destroy
      redirect_to user_path(current_user), alert: '投稿を削除しました'
    else
      render 'edit'
    end
  end

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @post_images = @tag.post_images.preload(:user).page(params[:page]).per(8)
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title,
                                       :image,
                                       :image_introduction,
                                       :post_image_genre,
                                       :user_id).merge(user_id: current_user.id)
  end
end
