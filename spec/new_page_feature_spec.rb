require 'http_helper'

require 'server'

feature 'Adding a Page to niki' do
  it 'adds the page' do
    page_title = 'the page title'
    page_content = 'the page content'
    post '/new-page', {:title => page_title, :content => page_content}
    page = Page.with(page_title, page_content)
    @niki.pages.must_include page
  end
end
