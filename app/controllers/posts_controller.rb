class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 2)
  end

  def show
    user_id = params[:user_id]
    post_id = params[:id]
    @user = User.find(user_id)
    @post = Post.find(post_id)
  end
end
