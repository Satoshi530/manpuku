class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_users_path
  end
end
