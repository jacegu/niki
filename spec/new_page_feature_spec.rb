require 'feature_helper'
require 'http_helper'

feature 'Adding a Page to niki' do

  describe 'new page form' do
    before do
      response = get '/new-page'
      @page_content = response.body
    end

    it 'renders a form for the new page data' do
      @page_content.must_match /<form.+method=('|")POST('|").+action=('|")\/new-page('|")/i
    end

    it 'renders a field for the page title' do
      @page_content.must_match /<input.+name=('|")title('|")/
    end

    it 'renders a field for the page content' do
      @page_content.must_match /<textarea.+name=('|")content('|")/
    end

    it 'renders an add page button' do
      @page_content.must_match /<input.*type=('|")submit('|").+Add page/
    end
  end

  describe 'adding the page with given title and content' do
    it 'adds the page' do
      page_title = 'the page title'
      page_content = 'the page content'
      post '/new-page', {:title => page_title, :content => page_content}
      page = Page.with(page_title, page_content)
      @niki.pages.must_include page
    end

    it 'prompts an error message if no title was given'
  end
end
