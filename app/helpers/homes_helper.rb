module HomesHelper
  # creates list of states to select from during home creation process
  def state_list
    state_codes = []
    us = Carmen::Country.coded('US')
    states = us.subregions.typed('state')
    states.each do |state|
      individual_code = state.code
      state_codes << individual_code
    end
    return state_codes
  end

  # takes individual address fields and combines them into one address field in the home table
  def address(home_id)
    @home = Home.find(home_id)
    location = [@home.street, @home.city, @home.state, @home.zip_code].compact.join(', ')
    @home.address = location
    @home.save
    return location
  end

  def weather(home_id)
    @home = Home.find(home_id)
    path = "https://api.openweathermap.org/data/2.5/weather?zip=" + "#{@home.zip_code}" + ",us&units=imperial&appid=0015579483ea0225b3814537df74bf36"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    weather = JSON.parse(response)
    @home.weather_id = weather['weather'][0]['id']
    @home.weather_main = weather['weather'][0]['main']
    @home.weather_description = weather['weather'][0]['description']
    @home.weather_icon = weather['weather'][0]['icon']
    @home.current_temp = weather['main']['temp']
    @home.feels_like = weather['main']['feels_like']
    @home.temp_min = weather['main']['temp_min']
    @home.temp_max = weather['main']['temp_max']
    @home.sunrise = weather['sys']['sunrise']
    @home.sunset = weather['sys']['sunset']
    @home.save
  end

  def timezone(home_id)
    @home = Home.find(home_id)
    zone = Timezone.lookup(@home.latitude, @home.longitude)
    @home.timezone = zone
    @home.save
  end

end
