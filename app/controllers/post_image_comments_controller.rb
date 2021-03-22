class PostImageCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_image_comments = @post_image.post_image_comments.order('created_at DESC')
    @post_image_comment = PostImageComment.new(post_image_comment_params)
    @post_image_comment.post_image_id = @post_image.id
    if @post_image_comment.save
      respond_to do |format|
        format.js { flash.now[:notice] = "コメントを送信しました" }
      end
      @post_image.create_notification_post_image_comment(current_user)
    else
      render 'error'
    end
  end

  def destroy
    @post_image = PostImage.find_by(id: params[:post_image_id])
    @post_image_comments = @post_image.post_image_comments.order('created_at DESC')
    PostImageComment.find_by(id: params[:id], post_image_id: params[:post_image_id]).destroy
    respond_to do |format|
      format.js { flash.now[:alert] = "コメントを削除しました" }
    end
  end

  private
    def post_image_comment_params
      params.require(:post_image_comment).permit(:comment, :user_id).merge(user_id: current_user.id)
    end
end
