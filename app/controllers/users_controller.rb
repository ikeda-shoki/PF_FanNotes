class UsersController < ApplicationController
  before_action :ensure_current_user, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
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
  
  def withdrawal
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to user_withdrawal_path
    else
      render 'edit'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:account_name, :user_introduction, :profile_image, :is_reception)
    end
    
    def ensure_current_user
      user = User.find(params[:id])
      if user != current_user
        redirect_to user_path(current_user)
      end
    end
end
