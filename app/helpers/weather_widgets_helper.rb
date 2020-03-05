module WeatherWidgetsHelper

  def create_weather_widget(id)
    @home = Home.find(id)
    weather_data = generate_forecast_today(@home.zip_code)
    @weather_widget = WeatherWidget.create(weather_data)
    @weather_widget.home_id = @home.id
    @weather_widget.save!
    @home.weather_widget_id = @weather_widget.id
    @home.save
end

  def generate_forecast_today(zip_code)
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

  def forecast_data(zip_code)
    path = "https://api.openweathermap.org/data/2.5/forecast?zip=" + "#{zip_code}" + ",us&units=imperial&appid=0015579483ea0225b3814537df74bf36"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    forecast = JSON.parse(response)
    forecast
  end

  def update_forecast(zip_code)
    forecast_hash = Hash.new
    forecast = forecast_data(zip_code)
    forecast['list'].each do |day|
      today = day['dt']
      final_today = Time.at(today)
      puts final_today.strftime('%-m/%-d %I:%M %P')
    end
  end



  end



  def update_weather_widget(id)
    @weather_widget = WeatherWidget.find(id)
    @home = Home.find(@weather_widget.home_id)
    weather_data = generate_forecast_today(@home.zip_code)
    @weather_widget.update(weather_data)
    @weather_widget.updated_at = Time.now
    @weather_widget.save!
  end

end