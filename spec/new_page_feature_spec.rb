require 'http_helper'

require 'server'

describe 'Adding a Page to niki' do
  before do
    @niki = Niki.new
    @server = Server.new(@niki, HttpTesting::DEFAULT_PORT)
    Thread.new{ @server.start }
  end

  after do
    @server.stop
  end

  it 'adds the page' do
    page_title = 'the page title'
    page_content = 'the page content'
    post '/new-page', {:title => page_title, :content => page_content}
    page = Page.with(page_title, page_content)
    @niki.pages.must_include page
  end
end
