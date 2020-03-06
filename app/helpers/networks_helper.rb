module NetworksHelper

  def internet_connection?
    check = Net::Ping::External.new('www.google.com')
    check.ping?
  end

  def find_networks
    result = system('netsh lan show networks')
    puts result.to_h
  end
end
