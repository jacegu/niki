require 'feature_helper'
require 'http_helper'

feature "Showing an existing wiki page" do

  describe 'requested page exists' do
    before do
      page_content = "Content\nfor\nthis\npage"
      @page = Niki::Page.with('Testing page', page_content)
      @wiki.add_page(@page)
      @page_html = (get '/pages/testing-page').body
    end

    it 'renders the title inside an <h1> tag' do
      @page_html.must_match /<h1>#{@page.title}<\/h1>/
    end

    it 'renders the page content' do
      @page_html.must_match /Content.+for.+this.+page/m
    end

    it 'renders an edit page link' do
      @page_html.must_match /<a.+href=("|')\/pages\/testing-page\/edit("|')/i
    end
  end

  describe 'requested page does not exist' do
    it 'returns a 404 error' do
      response = get '/pages/non-existing-page-for-sure'
      response.code.must_equal '404'
    end
  end

end
