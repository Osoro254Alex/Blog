class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all.order(:id).includes(:posts)
  end

  def show
    @user = User.includes(posts: %i[likes comments]).find(params[:id])
    @user = User.includes(posts: [:comments]).find(params[:id])

    respond_to do |format|
      format.html
      format.json do
        render json: @user.as_json(
          include: { posts: { include: { comments: { only: %i[id text] } },
                              only: %i[id title text] } }, only: %i[id name photo bio]
        )
      end
    end
  end
end
