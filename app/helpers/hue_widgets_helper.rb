module HueWidgetsHelper

  def create_hue_widget(id)
    @home = Home.find(id)
    @hue_widget = HueWidget.create
    @hue_widget.home_id = @home.id
    @hue_widget.save
  end

  def register_hue_user
    data = { "devicetype"=>"lights" }
    response = @http.post "/api", data.to_json
    result = JSON.parse(response.body).first
    if result.has_key? "error"
      process_error result
    elsif result["success"]
      @username = result["success"]["username"]
    end
    result
  end

end