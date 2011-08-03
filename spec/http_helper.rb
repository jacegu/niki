require 'uri'
require 'net/http'

DEFAULT_HOST = '0.0.0.0'
DEFAULT_PORT = '80'

module HttpTesting
  def get(resource, host = DEFAULT_HOST, port = DEFAULT_PORT)
    url = URI.parse("#{host}:#{port}#{resource}")
    request  = Net::HTTP::Get.new(url.path)
    response = Net::HTTP.start(url.host, url.port){ |http| http.request(request) }
  end
end

class MiniTest::Unit::TestCase
  include HttpTesting
end
