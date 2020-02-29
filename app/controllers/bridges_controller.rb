class BridgesController < ApplicationController

  def create
    bridge_data = helpers.find_bridges
    @bridge = Bridge.create(bridge_data)
    @bridge.save
  end

  def edit
    @home = Home.find(params[:home_id])
    @bridges = Bridge.where(home_id: @home.id)
  end

  def update
    @home = Home.find(params[:home_id])
    @bridges = Bridge.where(home_id: @home.id)
    @bridge = Bridge.find(params[:id])
    helpers.find_bulbs(@bridge.internalip, @bridge.username)
    if @bridge.username.nil?
      helpers.register_hue_user(@bridge.internalip)
      render 'edit'
    else
      helpers.create_bulbs(@bridge.id)
      render 'edit'
    end
  end

end