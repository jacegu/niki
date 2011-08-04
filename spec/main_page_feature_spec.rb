require 'spec_helper'
require 'http_helper'

require 'niki'
require 'server'

describe "Nicki's Main Page" do

  before do
    niki = Niki.new
    @server = Server.new(niki)
    Thread.new{ @server.start }
  end

  after do
    @server.stop
  end

  describe 'if no page has been created' do
    it 'prompts a message telling there are no pages created' do
      response = get '/'
      response.body.must_match /no niki has been created/
    end
  end
end
