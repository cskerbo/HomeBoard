class ListsController < ApplicationController

  def new
    @list = List.new
    @lists = List.all
    @home = Home.find(params[:home_id])
  end

  def show
    @list = List.find(params[:id])
    @item = Item.new
  end

  def edit
    @user = current_user
    @home = Home.find(params[:home_id])
    @list = List.find(params[:id])
    @item = Item.new
  end

  def index
    @user = current_user
    @home = Home.find(params[:home_id])
    @lists = List.where(home_id: @home.id)
    @list = List.new
    @item = Item.new
  end

  def update
    @user = current_user
    @home = Home.find(params[:home_id])
    @list = List.find(params[:id])
    @list.update(list_params)
    redirect_to user_home_lists_path(current_user, @home.id)
  end

  def create
    @list = List.new(list_params)
    @user = current_user
    @home = Home.find(params[:home_id])
    if @list.save!
      redirect_to user_home_path(current_user, @list.home_id)
    else
      @lists = List.all
      render :index
    end
  end

  def destroy
    list = List.find(params[:id])
    home_id = list.home_id
    list.destroy
    redirect_to user_home_lists_path(current_user, home_id)
  end
  private

  def list_params # strong parameters
    params.require(:list).permit(:name, :home_id)
  end
end