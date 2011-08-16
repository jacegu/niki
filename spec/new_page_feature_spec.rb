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
      @page_content.must_match /<input.+name=('|")title('|")/i
    end

    it 'renders a field for the page content' do
      @page_content.must_match /<textarea.+name=('|")content('|")/i
    end

    it 'renders an create niki button' do
      @page_content.must_match /<input.*type=('|")submit('|").+Create it/i
    end
  end

  describe 'adding the page with given title and content' do
    it 'adds the page' do
      page_title = 'the page title'
      page_content = 'the page content'
      post '/new-page', {:title => page_title, :content => page_content}
      last_page = @niki.pages.last
      last_page.title.must_equal page_title
      last_page.content.must_equal page_content
    end

    it 'prompts an error message if no title was given' do
      page_content = 'the page content'
      response = post '/new-page', {:content => page_content}
      response.body.must_match /must have a title/
    end
  end
end
