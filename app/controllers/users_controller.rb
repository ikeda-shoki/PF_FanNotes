class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]
  before_action :get_user, only: [:show, :edit, :update, :destroy, :following, :followed]

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |guest|
      guest.user_name = "ゲスト太朗"
      guest.account_name = "ゲスト"
      guest.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to main_post_images_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def get_user
    @user = User.find(params[:id])
  end

  def show
    @post_images = Kaminari.paginate_array(@user.post_images.reverse_order).page(params[:normal_page]).per(6)
    favorites = Favorite.favorite_post_image(@user.id)
    @my_favorite_images = Kaminari.paginate_array(PostImage.preload(:user).find(favorites.reverse)).page(params[:favorite_page]).per(6)
    @my_follower_images = Kaminari.paginate_array(PostImage.preload(:user).following_img(@user.following_user)).page(params[:follow_page]).per(6)
  end

  def index
    @users = User.all.page(params[:page]).per(5)
    # 並び替え機能はsearch_controller, post_image.rbに記載
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to withdrawal_users_path
    else
      render 'edit'
    end
  end

  # 退会画面
  def withdrawal
  end

  # フォローユーザー画面
  def following
    @followers = Kaminari.paginate_array(@user.following_user).page(params[:page]).per(14)
  end

  # フォロワーユーザー画面
  def followed
    @followed = Kaminari.paginate_array(@user.followed_user).page(params[:page]).per(14)
  end

  private

  def user_params
    params.require(:user).permit(:account_name, :user_introduction, :profile_image, :is_reception)
  end

  def ensure_current_user
    user = User.find(params[:id])
    unless user === current_user
      redirect_to user_path(current_user)
    end
  end
end
