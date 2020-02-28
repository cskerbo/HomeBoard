module WeatherWidgetsHelper

  def create_weather_widget(id)
    @home = Home.find(id)
    weather_data = generate_weather_data(@home.zip_code)
    @weather_widget = WeatherWidget.create(weather_data)
    @weather_widget.home_id = @home.id
    @weather_widget.save!
    @home.weather_widget_id = @weather_widget.id
    @home.save
end

  def generate_weather_data(zip_code)
    weather_data = Hash.new
    path = "https://api.openweathermap.org/data/2.5/weather?zip=" + "#{zip_code}" + ",us&units=imperial&appid=0015579483ea0225b3814537df74bf36"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    weather = JSON.parse(response)
    weather_data[:weather_id] = weather['weather'][0]['id']
    weather_data[:weather_main] = weather['weather'][0]['main']
    weather_data[:weather_description] = weather['weather'][0]['description']
    weather_data[:weather_icon] = weather['weather'][0]['icon']
    weather_data[:current_temp] = weather['main']['temp']
    weather_data[:feels_like] = weather['main']['feels_like']
    weather_data[:temp_min] = weather['main']['temp_min']
    weather_data[:temp_max] = weather['main']['temp_max']
    weather_data[:sunrise] = weather['sys']['sunrise']
    weather_data[:sunset] = weather['sys']['sunset']
    return weather_data
  end

  def update_weather_widget(id)
    @weather_widget = WeatherWidget.find(id)
    @home = Home.find(@weather_widget.home_id)
    weather_data = generate_weather_data(@home.zip_code)
    @weather_widget.update(weather_data)
    @weather_widget.updated_at = Time.now
    @weather_widget.save!
  end

end