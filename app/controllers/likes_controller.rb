class LikesController < ApplicationController
  def create
    @like = Like.create(author_id: params[:user_id], post_id: params[:post_id])

    if @like.save
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Liked 👍'
    else
      redirect_to user_post_path(params[:user_id], params[:post_id]), alert: 'An error occured, please try again!'
    end
  end
end
