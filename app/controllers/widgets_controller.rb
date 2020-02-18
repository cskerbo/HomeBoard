class WidgetsController < ApplicationController

  def new
    @widget = Widget.new
  end

  def index
    @user = current_user
    @home = Home.find(params[:home_id])
    @widget = Widget.new
  end

  def create
    @widget = Widget.create(widget_params)
    @widget.save!
    home_id = Home.find(params[:home_id])
    if @widget.weather_widget?
      WeatherWidget.create({"widgets_id"=>"#{@widget.id}"})
    end
  end

  private

  def widget_params
    params.require(:widget).permit(:weather_widget, :pet_widget, :task_widget, :grocery_widget, :network_widget, :ring_widget, :hue_widget)
  end
end
