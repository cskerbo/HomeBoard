module GroupsHelper

  def change_group_status(bridge_id, group_id)
    @bridge = Bridge.find(bridge_id)
    @group = Group.find(group_id)
    uri = URI("http://#{@bridge.internalip}/api/#{@bridge.username}/groups/#{@group.identifier}/action")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, 'Content-Type' => 'application/json')
    req.body = {"on":@group.state}.to_json
    res = http.request(req)
    puts "response #{res.body}"
    puts JSON.parse(res.body)
  end

  def change_group_brightness(bridge_id, group_id)
    @bridge = Bridge.find(bridge_id)
    @group = Group.find(group_id)
    uri = URI("http://#{@bridge.internalip}/api/#{@bridge.username}/groups/#{@group.identifier}/action")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, 'Content-Type' => 'application/json')
    req.body = {"bri":@group.brightness}.to_json
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
    unless @bridge.username.nil?
    group_data = find_groups(@bridge.internalip, @bridge.username)
    group_data.each do |group|
      @group = Group.new
      @group.state = group[1]['state']['all_on']
      @group.lights = group[1]['lights']
      @group.group_type = group[1]['type']
      @group.name = group[1]['name']
      @group.brightness = group[1]['action']['bri']
      @group.identifier = group[0]
      @group.bridge_id = @bridge.id
      @group.save!
    end
    end
  end

  def refresh_group_data(bridge_id)
    @bridge = Bridge.find(bridge_id)
    group_data = find_groups(@bridge.internalip, @bridge.username)
    group_data.each do |group|
      @group = Group.find_by(identifier: group[0])
      @group.update(state: group[1]['state']['all_on'])
      @group.update(brightness: group[1]['action']['bri'])
    end
  end

  def current_scene?(group_id, scene_id)
    if group_id == scene_id
      return true
    else
      return false
    end
  end

end
