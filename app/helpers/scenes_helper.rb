module ScenesHelper

  def set_scene(bridge_id, group_id, scene_id)
    @bridge = Bridge.find(bridge_id)
    @group = Group.find(group_id)
    @scene = Scene.find(scene_id)
    uri = URI("http://#{@bridge.internalip}/api/#{@bridge.username}/groups/#{@group.identifier}/action")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Put.new(uri.path, 'Content-Type' => 'application/json')
    req.body = {"scene":@scene.identifier}.to_json
    res = http.request(req)
    puts "response #{res.body}"
    puts JSON.parse(res.body)
  end

  def find_scenes(ip, username)
    path ="http://#{ip}/api/#{username}/scenes"
    uri = URI.parse(path)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    if result.first.is_a?(Hash) && result.first.has_key?("error")
      flash[:error] = "error"
    end
    result
  end

  # @param [Object] bridge_id
  def create_scenes(bridge_id)
    @bridge = Bridge.find(bridge_id)
    scene_data = find_scenes(@bridge.internalip, @bridge.username)
    scene_data.each do |scene|
      @scene = Scene.new
      @scene.group_number = scene[1]['group']
      unless @scene.group_number.nil?
      @scene.identifier = scene[0]
      @scene.name = scene[1]['name']
      @group = Group.find_by(identifier: @scene.group_number)
      @scene.group_id = @group.id
      @scene.save!
      end
      end
  end

end
