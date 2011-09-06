require 'feature_helper'
require 'http_helper'

feature 'Rendering the content of a wiki page' do

  describe 'rendering a page with a link to an existing page' do
    before do
      @wiki.add_page Niki::Page.with('page1', 'some content')
      @wiki.add_page Niki::Page.with('page2', "text [page1]\n more text")
      response = get '/pages/page2'
      @page_html = response.body
    end

    it 'renders a link to the page entitled "page1"' do
      @page_html.must_match /<a.+href=('|")\/pages\/page1('|")>page1<\/a>/i
    end
  end
end
