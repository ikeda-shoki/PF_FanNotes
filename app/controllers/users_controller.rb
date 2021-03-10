class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :withdrawal]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to user_withdrawal_path
    else
      render 'edit'
    end
  end
  
  #退会画面
  def withdrawal
  end
  
  #フォローユーザー画面
  def following
    @user = User.find(params[:id])
    @followers = @user.following_user
  end
  
  #フォロワーユーザー画面
  def followed
    @user = User.find(params[:id])
    @followed = @user.followed_user
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
