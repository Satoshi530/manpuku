class User::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "User"
      @users = User.looks(@word)
    elsif @range == "Post"
      @posts = Post.looks(@word)
    elsif @range == "Tag"
      @tags = Tag.looks(@word)
      tag = Tag.find_by(name: @word)
      @posts = tag.posts.all
    end
  end
end
