class Admin::PostCommentsController < ApplicationController
  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
  end
end
