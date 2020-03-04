class PetsController < ApplicationController

  def update
    @pet = Pet.find(params[:id])
    @home = Home.find(@pet.home_id)
    if params[:button] == '1'
      helpers.update_status1(@pet, @home)
      respond_to do |format|
        format.js
      end
    elsif params[:button] == '2'
      helpers.update_status2(@pet, @home)
      respond_to do |format|
        format.js
      end
    end

  end

  private

  def pet_params
    params.require(:pet).permit(:feeding, :bathroom_break, :walk, :pet_type, :home_id, :day, :name)
  end
end