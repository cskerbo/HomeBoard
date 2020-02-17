class HomesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @home = Home.new
    @states = helpers.state_list
  end

  def create
    @user = current_user
    @states = helpers.state_list
    @home = Home.create(home_params)
    #@home.user_ids = @user.id
    if @home.save
      helpers.address(@home.id)
      helpers.weather(@home.id)
      helpers.timezone(@home.id)
      redirect_to user_user_home_path(current_user, @home)
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    @home = Home.find(params[:id])
    if !@home.user_ids.include?(current_user.id)
      redirect_to '/403'
    end
  end

  def index
    @user = current_user
  end


  private

  def home_params
    params.require(:home).permit(:name, :zip_code, :street, :city, :state)
  end

end
