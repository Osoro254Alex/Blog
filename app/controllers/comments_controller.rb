class CommentsController < ApplicationController
  def create
    @comment = Comment.create(author_id: current_user.id, post_id: params[:post_id], text: params[:comment][:text])
    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end
end
