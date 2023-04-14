class CommentsController < ApplicationController
  def create
    @comment = Comment.create(author_id: current_user.id, post_id: params[:post_id], text: params[:comment][:text])
    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    if @comment.destroy
      flash[:success] = 'Comment was successfully destroyed'
      redirect_to user_post_path(@comment.post.author, @comment.post)
    else
      flash[:error] = 'Failed to destroy comment'
      redirect_to @comment.post
    end
  end
end
