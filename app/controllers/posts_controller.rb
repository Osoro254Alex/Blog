class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:likes, :comments).paginate(page: params[:page], per_page: 2)
  end

  def show
    @user_id = params[:user_id]
    @post_id = params[:id]
    @post = Post.includes(:likes, :comments).find(@post_id)
    @user = User.find(@user_id)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(author_id: params[:post][:user_id], title: params[:post][:title], text: params[:post][:text].gsub(/\r\n?/, '<br>'))

    if @post.save
      redirect_to user_path(params[:post][:user_id]), notice: 'Post was successfully created.'
    else
      render :new
      flash.alert = 'Error!, Post not added!'
    end
  end
  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    if @post.destroy
      flash[:success] = "post was successfully destroyed"
      redirect_to user_posts_path(@post.author)
    else
      flash[:error] = "Failed to destroy post"
      redirect_to @post
    end
  end
end
