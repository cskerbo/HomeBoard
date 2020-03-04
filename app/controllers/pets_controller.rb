class PetsController < ApplicationController

  def update
    @user = current_user
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
    else
      @pet.update(pet_params)
      redirect_to user_home_path(@user, @home)
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  private

  def pet_params
    params.require(:pet).permit(:status1, :status1_status, :status1_message, :status2, :status2_status, :status2_message, :day, :status1_time, :status2_time, :home_id)
  end
end