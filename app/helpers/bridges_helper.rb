module BridgesHelper

  def create_bridges(id)
    @hue_widget = HueWidget.find(id)
    bridge_data = find_bridges
    @bridge = Bridge.create(bridge_data)
    @bridge.hue_widget_id = @hue_widget.id
    @bridge.save
  end

  def find_bridges
    bridge_data = Hash.new
    http = Net::HTTP.new("www.meethue.com",443)
    http.use_ssl = true
    request = Net::HTTP::Get.new( "/api/nupnp" )
    response = http.request request

    case response.code.to_i
    when 200
      result = JSON.parse( response.body )
      bridge_data[:identifier] = result[0]['id']
      bridge_data[:internalip] = result[0]['internalipaddress']
      return bridge_data
    else
      raise "Unknown error"
    end
  end

end