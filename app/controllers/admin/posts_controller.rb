class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @user = @post.user
    @posts = @user.posts.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_users_path
  end
end
