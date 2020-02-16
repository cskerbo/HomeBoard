class UserHomesController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    @home = Home.find(params[:id])
    if !@home.user_ids.include?(@user.id)
      redirect_to '/403'
    end
  end

  def new
    @user = current_user
    @home = Home.new
    @states = helpers.state_list
  end

  def index
    @user = current_user
  end

end
