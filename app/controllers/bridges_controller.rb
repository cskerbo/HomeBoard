class BridgesController < ApplicationController

  def create
    bridge_data = helpers.find_bridges
    @bridge = Bridge.create(bridge_data)
    @bridge.save
  end

  def edit
    @bridge = Bridge.find(params[:id])
    @home = Home.find(params[:home_id])
  end

end