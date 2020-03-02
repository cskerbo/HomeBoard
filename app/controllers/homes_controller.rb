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
    @home.build_pet
    if @home.save
      helpers.address(@home.id)
      helpers.timezone(@home.id)
      helpers.create_list_widget(@home.id)
      helpers.create_weather_widget(@home.id) if @home.weather_widget?
      helpers.create_bridges(@home.id) if @home.hue_widget?
      redirect_to user_home_path(current_user, @home)
    else
      render 'index'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @home = Home.find(params[:id])
    helpers.update_weather_widget(@home.weather_widget_id) if @home.weather_widget?
    @weather_widget = WeatherWidget.find(@home.weather_widget_id) if @home.weather_widget?
    @pet = Pet.find_by_home_id(@home.id)
    @lists = List.where(home_id: @home.id)
    @item = Item.new
    @bridges = Bridge.where(home_id: @home.id)
    @groups = Group.where(bridge_id: @bridges)
    if @home.user_id != current_user.id || @user.id != current_user.id
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
  end

  def update
    @home = Home.find(params[:id])
    @home.update_attributes(home_params)
    helpers.create_weather_widget(@home.id) if @home.weather_widget?
    redirect_to user_home_path(current_user, @home)
  end

  def destroy
    @home = Home.find(params[:id])
    @home.destroy
      redirect_to user_homes_path(current_user)
  end

  private

  def home_params
    params.require(:home).permit(:name, :zip_code, :street, :city, :state, :weather_widget, :pet_widget, :hue_widget, :list_widget, :user_id,
                                 lists_attributes: [
                                     :name
                                 ],
                                 pet_attributes: [
                                     :feeding,
                                     :id,
                                     :bathroom_break,
                                     :walk,
                                     :pet_type,
                                     :home_id
                                 ]
    )
  end

end
