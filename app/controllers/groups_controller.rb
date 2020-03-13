class GroupsController < ApplicationController

  def update
    @group = Group.find(params[:id])
    @bridge = Bridge.find(@group.bridge_id)
    @bridges = Bridge.where(home_id: @bridge.home_id)
    @group.update(group_params)
    if group_params.include?(:state)
    helpers.change_group_status(@bridge.id, @group.id)
    end
    if group_params.include?(:brightness)
      helpers.change_group_brightness(@bridge.id, @group.id)
    end
    helpers.refresh_group_data(@bridge.id)
    respond_to do |format|
      format.js
    end
  end

  private

  def group_params
    params.require(:group).permit(:state, :brightness)
  end
end