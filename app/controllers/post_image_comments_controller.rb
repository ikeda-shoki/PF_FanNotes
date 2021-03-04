class PostImageCommentsController < ApplicationController

  def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_image_comment = PostImageComment.new(post_image_comment_params)
    @post_image_comment.post_image_id = @post_image.id
    if @post_image_comment.save
      redirect_to post_image_path(@post_image)
    else
      @post_image_comments = @post_image.post_image_comments
      render 'post_images/show'
    end
  end

  def destroy
    if PostImageComment.find_by(id: params[:id], post_image_id: params[:post_image_id]).destroy
      redirect_back(fallback_location: post_image_path(params[:post_image_id]))
    else
      render 'post_images/show'
    end
  end

  private
    def post_image_comment_params
      params.require(:post_image_comment).permit(:comment, :user_id).merge(user_id: current_user.id)
    end
end
