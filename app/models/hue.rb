class Hue < ApplicationRecord

  def discover_bridge
    http = Net::HTTP.new("www.meethue.com",443)
    http.use_ssl = true
    request = Net::HTTP::Get.new( "/api/nupnp" )
    response = http.request request

    case response.code.to_i
    when 200
      result = JSON.parse( response.body )
      result[0]['id'] =
          result[0]['internalipaddress'] =
    else
      raise "Unknown error"
    end
  end

end