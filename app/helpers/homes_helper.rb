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

  def timezone(home_id)
    @home = Home.find(home_id)
    zone = Timezone.lookup(@home.latitude, @home.longitude)
    @home.timezone = zone
    @home.save
  end

  def quote_of_the_day(home_id)
    @home = Home.find(home_id)
    path = "https://quotes.rest/qod?language=en"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    quote_data = JSON.parse(response)
    quote = quote_data['contents']['quotes'][0]['quote']
    author = quote_data['contents']['quotes'][0]['author']
    @home.update(quote: quote)
    @home.update(quote_author: author)
  end

end
