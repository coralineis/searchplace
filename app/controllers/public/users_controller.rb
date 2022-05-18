class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @plans = @user.plans
    @likes = Like.where(user_id: current_user.id).pluck(:id)
    @like_list = Place.find(@likes)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to my_page_path(current_user)
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :prefecture, :email, :password)
  end

end
