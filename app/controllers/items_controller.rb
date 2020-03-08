class ItemsController < ApplicationController
  def create
    @user = current_user
    @list = List.find(params[:list_id]) # finding the parent
    @new_item = Item.new
    @home = Home.find(params[:home_id])
    @lists = @home.lists
    if @new_item.save!
      respond_to do |format|
        format.js
      end
    else
      render "lists/show"
    end
  end


  def update
    @user = current_user
    @new_item = Item.new
    @item = Item.find(params[:id])
    @item.update(item_params)
    list = List.find(@item.list_id)
    @home = Home.find(list.home_id)
    @lists = @home.lists
    respond_to do |format|
      format.js
    end
  end

  private
  def item_params
    params.require(:item).permit(:description, :status)
  end

end
