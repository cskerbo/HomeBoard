class ScenesController < ApplicationController

  def update
    @scene = Scene.find(params[:id])
    @group = Group.find_by(id: @scene.group_id)
    @bridge = Bridge.find(@group.bridge_id)
    @bridges = Bridge.where(home_id: @bridge.home_id)
    helpers.set_scene(@bridge.id, @group.id, @scene.id)
    helpers.refresh_group_data(@bridge.id)
    respond_to do |format|
      format.js
    end
  end

end