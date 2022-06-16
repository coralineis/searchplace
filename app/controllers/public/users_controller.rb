class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @places = @user.places.order(id: "DESC")
    likes = Like.where(user_id: current_user.id).pluck(:place_id)
    @likes = Place.find(likes)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render template: 'public/registrations/edit'
    else
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
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
