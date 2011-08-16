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

  describe 'adding the page to niki' do
    describe 'a non empty title is provided' do
      it 'adds the page' do
        page_title = 'the page title'
        page_content = 'the page content'
        post '/new-page', {:title => page_title, :content => page_content}
        last_page = @niki.pages.last
        last_page.title.must_equal page_title
        last_page.content.must_equal page_content
      end
    end

    describe 'the title is not provided' do
      before do
        @written_content = 'some content'
        @response = post '/new-page', {:content => @written_content}
      end

      it 'prompts an error message if no title was given' do
        @response.body.must_match /must have a title/
      end

      it 'mantains the written content if no title is provided' do
        @response.body.must_match /#{@written_content}/
      end
    end

    describe 'the title is provided but is empty' do
      before do
        @written_content = 'some content'
        @response = post '/new-page', {:title => '', :content => @written_content}
      end

      it 'prompts an error message if the title is empty' do
        @response.body.must_match /must have a title/
      end

      it 'mantains written content if the title is empty ' do
        @response.body.must_match /#{@written_content}/
      end
    end
  end

end
