class ListsController < ApplicationController

  def new
    @list = List.new
    @lists = List.all
    @home = Home.find(params[:home_id])
  end

  def show
    @home = Home.find(params[:home_id])
    @list = List.find(params[:id])
    @item = Item.new
  end

  def edit
    @user = current_user
    @home = Home.find(params[:home_id])
    @list = List.find(params[:id])
    @new_item = Item.new
  end

  def index
    @user = current_user
    @home = Home.find(params[:home_id])
    @new_list = List.new
    @new_item = Item.new
  end

  def update
    @user = current_user
    @list = List.find(params[:id])
    @home = Home.find(@list.home_id)
    @list.update(list_params)
    @new_list = List.new
    redirect_to user_home_lists_path(current_user, @home.id)
  end

  def create
    @list = List.new(list_params)
    @user = current_user
    @home = Home.find(params[:home_id])
    @new_list = List.new
    if @list.save!
      @lists = List.all
      render :index
    else
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