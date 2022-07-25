class User::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "編集しました"
    redirect_to user_path
  end

  def favorites
    @user = User.find(params[:id])
    @posts = @user.favorite_posts.page(params[:page])
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
