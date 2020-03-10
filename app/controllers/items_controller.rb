class ItemsController < ApplicationController
  def create
    @user = current_user
    @list = List.find(params[:list_id]) # finding the parent
    @item = @list.items.build(item_params)
    @new_item = Item.new
    @home = Home.find(params[:home_id])
    @lists = @home.lists
    if @item.save!
      respond_to do |format|
        format.js
      end
    else
      render "lists/show"
    end
  end

  def update
    @user = current_user
    @item = Item.find(params[:id])
    @new_item = Item.new
    @item.update(item_params)
    @list = List.find(@item.list_id)
    @home = Home.find(@list.home_id)
    @lists = @home.lists
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = current_user
    @list = List.find(params[:list_id])
    @home = Home.find(@list.home_id)
    @new_item = Item.new
    @lists = @home.lists
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def item_params
    params.require(:item).permit(:description, :status)
  end

end
