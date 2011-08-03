require 'uri'
require 'net/http'

DEFAULT_URL  = '0.0.0.0'
DEFAULT_PORT = '80'

module HttpTesting
  def get(resource, url = DEFAULT_URL, port=DEFAULT_PORT)
    url = URI.parse("#{url}:#{port}#{resource}")
    request = Net::HTTP::Get.new(url.path)
    response = Net::HTTP.start(url.host, url.port) do |http|
      http.request(request)
    end
  end
end

class MiniTest::Unit::TestCase
  include HttpTesting
end
