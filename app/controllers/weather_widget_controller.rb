class WeatherWidgetController < ApplicationController


  def create
    @weather_widget = WeatherWidget.new
    @home = Home.find(params[:id])
    path = "https://api.openweathermap.org/data/2.5/weather?zip=" + "#{@home.zip_code}" + ",us&units=imperial&appid=0015579483ea0225b3814537df74bf36"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    weather = JSON.parse(response)
    @weather_widget.weather_id = weather['weather'][0]['id']
    @weather_widget.weather_main = weather['weather'][0]['main']
    @weather_widget.weather_description = weather['weather'][0]['description']
    @weather_widget.weather_icon = weather['weather'][0]['icon']
    @weather_widget.current_temp = weather['main']['temp']
    @weather_widget.feels_like = weather['main']['feels_like']
    @weather_widget.temp_min = weather['main']['temp_min']
    @weather_widget.temp_max = weather['main']['temp_max']
    @weather_widget.sunrise = weather['sys']['sunrise']
    @weather_widget.sunset = weather['sys']['sunset']
    @weather_widget.home_id = @home.id
    @weather_widget.save
  end

end
