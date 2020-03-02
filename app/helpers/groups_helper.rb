module GroupsHelper

  def change_group_status(bridge_id, group_id)
    @bridge = Bridge.find(bridge_id)
    @group = group.find(group_id)
    uri = URI("http://#{@bridge.internalip}/api/#{@bridge.username}/lights/#{@group.identifier}/state")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, 'Content-Type' => 'application/json')
    req.body = {"on":@group.on}.to_json
    res = http.request(req)
    puts "response #{res.body}"
    puts JSON.parse(res.body)
  end

  def find_groups(ip, username)
    path ="http://#{ip}/api/#{username}/groups"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    if result.first.is_a?(Hash) && result.first.has_key?("error")
      flash[:error] = "error"
    end
    result
  end

  # @param [Object] bridge_id
  def create_groups(bridge_id)
    @bridge = Bridge.find(bridge_id)
    group_data = find_groups(@bridge.internalip, @bridge.username)
    group_data.each do |group|
      @group = Group.new
      @group.state = group[1]['state']['all_on']
      @group.lights = group[1]['lights']
      @group.group_type = group[1]['type']
      @group.name = group[1]['name']
      @group.identifier = group[0]
      @group.bridge_id = @bridge.id
      @group.save!
    end
  end

  def refresh_group_data(bridge_id)
    group_data = find_groups(@bridge.internalip, @bridge.username)
    group_data.each do |group|
      @group = group.find_by(identifier: group[0])
      @group.update(on: group[1]['state']['on'])
      @group.update(brightness: group[1]['state']['bri'])
      @group.update(hue: group[1]['state']['hue'])
      @group.update(saturation: group[1]['state']['sat'])
      @group.update(color_temperature: group[1]['state']['ct'])
      @group.update(color_mode: group[1]['state']['colormode'])
      @group.update(effect: group[1]['state']['effect'])
      @group.update(name: group[1]['name'])
    end
  end

end
