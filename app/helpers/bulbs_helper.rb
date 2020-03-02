module BulbsHelper

  def change_bulb_status(bridge_id, bulb_id)
    @bridge = Bridge.find(bridge_id)
    @bulb = Bulb.find(bulb_id)
    uri = URI("http://#{@bridge.internalip}/api/#{@bridge.username}/lights/#{@bulb.identifier}/state")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, 'Content-Type' => 'application/json')
    req.body = {"on":@bulb.on}.to_json
    res = http.request(req)
    puts "response #{res.body}"
    puts JSON.parse(res.body)
  end

  def find_bulbs(ip, username)
    path ="http://#{ip}/api/#{username}/lights"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    if result.first.is_a?(Hash) && result.first.has_key?('error')
      flash[:error] = 'error'
    end
    result
  end

  # @param [Object] bridge_id
  def create_bulbs(bridge_id)
    @groups = Group.all
    @bridge = Bridge.find(bridge_id)
    bulb_data = find_bulbs(@bridge.internalip, @bridge.username)
    bulb_data.each do |bulb|
      @bulb = Bulb.new
      @bulb.on = bulb[1]['state']['on']
      @bulb.brightness = bulb[1]['state']['bri']
      @bulb.hue = bulb[1]['state']['hue']
      @bulb.saturation = bulb[1]['state']['sat']
      @bulb.color_temperature = bulb[1]['state']['ct']
      @bulb.color_mode = bulb[1]['state']['colormode']
      @bulb.effect = bulb[1]['state']['effect']
      @bulb.name = bulb[1]['name']
      @bulb.identifier = bulb[0]
      @bulb.bridge_id = @bridge.id
      @groups.each do |group|
        if group.lights.include?("#{@bulb.identifier}")
          @bulb.group_id = group.id
          @bulb.save!
        end
      end
    end
  end

  def refresh_bulb_data(bridge_id)
    bulb_data = find_bulbs(@bridge.internalip, @bridge.username)
    bulb_data.each do |bulb|
      @bulb = Bulb.find_by(identifier: bulb[0])
      @bulb.update(on: bulb[1]['state']['on'])
      @bulb.update(brightness: bulb[1]['state']['bri'])
      @bulb.update(hue: bulb[1]['state']['hue'])
      @bulb.update(saturation: bulb[1]['state']['sat'])
      @bulb.update(color_temperature: bulb[1]['state']['ct'])
      @bulb.update(color_mode: bulb[1]['state']['colormode'])
      @bulb.update(effect: bulb[1]['state']['effect'])
      @bulb.update(name: bulb[1]['name'])
    end
  end

end