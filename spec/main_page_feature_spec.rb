require 'http_helper'

require 'server'

describe "Niki's Main Page" do

  before do
    @niki = Niki.new
    @server = Server.new(@niki, HttpTesting::DEFAULT_PORT)
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

  describe 'if pages have been created' do
    before do
      @the_page_title = 'page title'
      @niki.add_page Page.new(@the_page_title)
    end

    it 'lists them showing their title' do
      response = get '/'
      response.body.must_match /#{@the_page_title}/
    end
  end

end
