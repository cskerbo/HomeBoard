class HueWidget < ApplicationRecord
  belongs_to :home
  has_many :bridges
  has_many :bulbs, through: :bridges

  def request_bulb_list
    get "lights"
  end

  def set_bulb_state( id, state )
    put "lights/#{id}/state", state
  end


  private

  def process_error(result)
    type = result["error"]["type"]
    case type
    when 1
      raise UsernameException
    when 3
      raise ResourceUnavailableException, result["error"]["description"]
    when 6
      raise ParameterUnavailableException, result["error"]["description"]
    when 101
      raise BridgeConnectException
    when 403
      raise SceneLockedException, result["error"]["description"]
    else
      raise "Unknown Error: #{result["error"]["description"]}"
    end
  end

  def get( path )
    @logger.debug "==> GET: #{path}"
    raise UsernameException unless @username
    request = Net::HTTP::Get.new( "/api/#{@username}/#{path}" )
    response = @http.request request
    result = JSON.parse( response.body )
    @logger.debug "<== #{response.code}"
    @logger.debug response.body
    if result.first.kind_of?(Hash) && result.first.has_key?("error")
      process_error result.first
    end
    result
  end

  def put( path, data={} )
    raise UsernameException unless @username
    response = @http.put( "/api/#{@username}/#{path}", data.to_json )
    result = JSON.parse( response.body )
    if result.first.kind_of?(Hash) && result.first.has_key?("error")
      process_error result.first
    end
    result
  end

  def post( path, data={} )
    raise UsernameException unless @username
    response = @http.post( "/api/#{@username}/#{path}", data.to_json )
    result = JSON.parse( response.body )
    if result.first.kind_of?(Hash) && result.first.has_key?("error")
      process_error result.first
    end
    result
  end

  def delete( path )
    raise UsernameException unless @username
    request = Net::HTTP::Delete.new( "/api/#{@username}/#{path}" )
    response = @http.request request
    result = JSON.parse( response.body )
    if result.first.kind_of?(Hash) && result.first.has_key?("error")
      process_error result.first
    end
    result
  end

end