class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @user = current_user
    @users = User.all
  end

  private

  def is_admin?
    user = current_user
    redirect_to root_path unless user.admin?
  end

end