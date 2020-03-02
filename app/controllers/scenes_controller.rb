class ScenesController < ApplicationController

  def update
    @group = Group.find(params[:group_id])
    @bridge = Bridge.find(@group.bridge_id)
    @bridges = Bridge.where(home_id: @bridge.home_id)
    @scene = Scene.find(params[:id])
    helpers.set_scene(@bridge.id, @group.id, @scene.id)
    respond_to do |format|
      format.js
    end
  end

end