class ItemsController < ApplicationController
  def create
    @list = List.find(params[:list_id]) # finding the parent
    @item = @list.items.build(item_params)
    @home = Home.find(params[:home_id])
    if @item.save!
      redirect_to user_home_path(current_user, @home.id)
    else
      render "lists/show"
    end
  end

  # PATCH - /lists/:list_id/items/:id
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)

    redirect_to list_path(@item.list)
  end

  private
  def item_params
    params.require(:item).permit(:description, :status)
  end

end