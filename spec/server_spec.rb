require 'spec_helper'
require 'uri'
require 'net/http'

TARGET_URL  = 'http://www.google.es'
TARGET_PORT = 80

describe 'testing through http protocol' do
  it 'can make a get request' do
    resource = '/'
    url = URI.parse("#{TARGET_URL}:#{TARGET_PORT}#{resource}")
    request = Net::HTTP::Get.new(url.path)
    response = Net::HTTP.start(url.host, url.port) do |http|
      http.request(request)
    end
    assert_match response.body, /google/
  end
end
