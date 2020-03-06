module WeatherWidgetsHelper

  def create_weather_widget(id)
    @home = Home.find(id)
    @weather_widget = WeatherWidget.new
    @weather_widget.home_id = @home.id
    @weather_widget.save!
    create_days(@home)
    current_weather_today(@weather_widget, @home)
    @home.update(weather_widget_id: @weather_widget.id)
  end

  def current_weather_today(weather_widget, home)
    current_day = Time.now.strftime('%-m/%-d')
    weather = forecast_data(home)
    weather_widget.days.each do |day|
      if day.date == current_day
        day.update(today: true)
        day.update(summary: weather['currently']['summary'])
        day.update(current_temp: weather['currently']['temperature'])
        day.update(feels_like: weather['currently']['apparentTemperature'])
        day.update(icon: weather['currently']['icon'])
        day.update(precipitation_type: weather['currently']['precipType'])
        day.update(precipitation_chance: weather['currently']['precipProbability'])
      end
    end
  end

  def forecast_data(home)
    path = "https://api.darksky.net/forecast/#{ENV['DARKSKY_SECRET']}/#{home.latitude},#{home.longitude}"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    forecast = JSON.parse(response)
    forecast
  end

  def create_days(home)
    @weather_widget = WeatherWidget.find_by_home_id(home.id)
    forecast = forecast_data(home)
    forecast['daily']['data'].each do |day|
      forecast_hash = Hash.new
      unformatted_date = day['time']
      unformatted_sunrise = day['sunriseTime']
      unformatted_sunset = day['sunsetTime']
      formatted_date = Time.at(unformatted_date).strftime('%-m/%-d')
      formatted_sunrise = Time.at(unformatted_sunrise).strftime('%l:%M %P')
      formatted_sunset = Time.at(unformatted_sunset).strftime('%l:%M %P')
      forecast_hash[:date] = formatted_date
      forecast_hash[:summary] = day['summary']
      forecast_hash[:icon] = day['icon']
      forecast_hash[:sunset] = formatted_sunset
      forecast_hash[:sunrise] = formatted_sunrise
      forecast_hash[:temp_high] = day['temperatureHigh']
      forecast_hash[:temp_low] = day['temperatureLow']
      forecast_hash[:precipitation_chance] = day['precipProbability']
      forecast_hash[:precipitation_type] = day['precipType']
      forecast_hash[:weather_widget_id] = @weather_widget.id
      Day.create(forecast_hash)
    end
  end

  def update_forecast(home_id)
    @home = Home.find(home_id)
    @weather_widget = WeatherWidget.find_by_home_id(@home.id)
    current_day = Time.now.strftime('%-m/%-d')
    weather = forecast_data(@home)
    weather['daily']['data'].each do |forecast_day|
      unformatted_sunrise = forecast_day['sunriseTime']
      unformatted_sunset = forecast_day['sunsetTime']
      unformatted_forecast_date = forecast_day['time']
      formatted_sunrise = Time.at(unformatted_sunrise).strftime('%l:%M %P')
      formatted_sunset = Time.at(unformatted_sunset).strftime('%l:%M %P')
      formatted_forecast_date = Time.at(unformatted_forecast_date).strftime('%-m/%-d')
      day = Day.where('date = ? AND weather_widget_id = ?', formatted_forecast_date, @weather_widget.id).first
      if day.date != current_day
        day.update(summary: forecast_day['summary'])
        day.update(icon: forecast_day['icon'])
        day.update(sunrise: formatted_sunrise)
        day.update(sunset: formatted_sunset)
        day.update(temp_high: forecast_day['temperatureHigh'])
        day.update(temp_low: forecast_day['temperatureLow'])
        day.update(precipitation_type: forecast_day['precipType'])
        day.update(precipitation_chance: forecast_day['precipProbability'])
      end
    end
    current_weather_today(@weather_widget, @home)
    @weather_widget.update(updated_at: Time.now)
  end

  def need_weather_update(home_id)
    @weather_widget = WeatherWidget.find_by_home_id(home_id)
    if @weather_widget.updated_at <= 1.minutes.ago
      update_forecast(home_id)
    end
  end

end