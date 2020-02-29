class BulbsController < ApplicationController

  def update
    @bulb = Bulb.find(params[:id])
    @bridge = Bridge.find(@bulb.bridge_id)
    @bridges = Bridge.where(home_id: @bridge.home_id)
    @bulb.update(bulb_params)
    helpers.change_bulb_status(@bridge.id, @bulb.id)
    respond_to do |format|
      format.js
    end
  end


  private
  def bulb_params
    params.require(:bulb).permit(:on)
  end
end