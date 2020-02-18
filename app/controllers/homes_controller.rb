class HomesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @home = Home.new
    @widget = Widget.new
    @states = helpers.state_list
  end

  def create
    @user = current_user
    @states = helpers.state_list
    @home = Home.create(home_params)
    @home.user_id = @user.id
    if @home.save
      helpers.address(@home.id)
      helpers.timezone(@home.id)
      redirect_to user_home_widgets_path(current_user, @home)
    else
      render 'index'
    end
  end

  def show
    @user = current_user
    @home = Home.find(params[:id])
    if @home.user_id != current_user.id
      redirect_to '/403'
    end
  end

  def index
    @user = current_user
    @home = Home.new
    @states = helpers.state_list
  end

  def edit
    @home = Home.find(params[:id])
    @user = current_user
    @states = helpers.state_list
    @widget = Widget.new
  end


  private

  def home_params
    params.require(:home).permit(:name, :zip_code, :street, :city, :state)
  end

end
