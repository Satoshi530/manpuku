class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集しました"
      redirect_to admin_user_path
    else
      render :edit
    end
    end
  end

  private
    def user_params
        params.require(:user).permit(:email, :password, :name, :is_deleted)
    end
end
