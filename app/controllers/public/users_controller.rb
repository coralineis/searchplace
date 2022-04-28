class Public::UsersController < ApplicationController
  def show
    @user = User.find(current_user)
end
