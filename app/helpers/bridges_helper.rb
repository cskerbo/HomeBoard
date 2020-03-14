module BridgesHelper

  def create_bridges(id)
    @bridge = Bridge.create(find_bridges)
    @bridge.home_id = id
    @bridge.save!
  end

  # @param [Object] internalip
  def register_hue_user(internalip)
    if @bridge.username.nil?
      http = Net::HTTP.new(internalip, 80)
      data = { 'devicetype'=>'homeboard' }
      response = http.post '/api', data.to_json
      result = JSON.parse(response.body).first
      if result.has_key? 'error'
        flash[:error] = result['error']['description']
      elsif result['success']
        @bridge.username = result['success']['username']
        @bridge.save!
        flash[:notice] = 'Bridge connection successful!'
      end
    end
  end

  private

  # @return [Hash]
  def find_bridges
    bridge_data = {}
    http = Net::HTTP.new('www.meethue.com',443)
    http.use_ssl = true
    request = Net::HTTP::Get.new('/api/nupnp')
    response = http.request request
    case response.code.to_i
    when 200
      result = JSON.parse( response.body )
      bridge_data[:identifier] = result[0]['id']
      bridge_data[:internalip] = result[0]['internalipaddress']
      bridge_data
    else
      raise 'Unknown error'
    end
  end
end
