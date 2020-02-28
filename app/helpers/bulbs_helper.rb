module BulbsHelper
  def find_bulbs(ip, username)
    bulb_data = []
    http = Net::HTTP.new(ip, 80)
    request = Net::HTTP::Get.new( "/api/#{username}/lights")
    response = http.request request
    result = JSON.parse(response, object_class: OpenStruct)
    if result.first.kind_of?(Hash) && result.first.has_key?("error")
      puts result
    end
    result
  end

def create_bulbs(bridge_id)
  bridge = Bridge.find(bridge_id)
  bulb_data = find_bulbs(bridge.internalip, bridge.username)
  bulb_data.each do |key, value|
    puts key
    puts value
  end
end

  end