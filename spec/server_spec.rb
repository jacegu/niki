require 'spec_helper'
require 'http_helper'

describe 'testing through http protocol' do
  it 'can make a get request' do
    response = get('/', 'http://www.google.es')
    response.code.must_equal '200'
  end
end
