require 'feature_helper'
require 'http_helper'

feature "An existing wiki page" do
  describe 'showing an existing page' do
    before do
      page_content = "Content\nfor\nthis\npage"
      @page = Niki::Page.with('Testing page', page_content)
      @wiki.add_page(@page)
    end

    it 'renders the title inside an <h1> tag' do
      response = get '/pages/testing-page'
      response.body.must_match /<h1>#{@page.title}<\/h1>/
    end
  end
end
