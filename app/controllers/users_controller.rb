class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin, :password_confirmation)
  end
end
