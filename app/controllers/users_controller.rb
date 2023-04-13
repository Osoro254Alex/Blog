class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all.includes(:posts)
  end

  def show
    @user = User.includes(posts: %i[likes comments]).find(params[:id])
  end
end
