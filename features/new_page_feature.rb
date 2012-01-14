#encoding: utf-8

require 'feature_helper'
require 'http_helper'

feature 'Adding a Page to the wiki' do

  describe 'rendering the form to add new page' do
    before do
      @response = get '/new-page'
    end

    it 'renders a form for the new page data' do
      @response.body.must_match /<form.+method=('|")POST('|").+action=('|")\/new-page('|")/i
    end

    it 'renders a field for the page title' do
      @response.body.must_match /<input.+name=('|")title('|")/i
    end

    it 'renders a field for the page content' do
      @response.body.must_match /<textarea.+name=('|")content('|")/i
    end

    it 'renders an create page button' do
      @response.body.must_match /<input.*type=('|")submit('|").+Create it/i
    end

    it 'renders a back to page list link' do
      @response.body.must_match /<a.+href=("|')\/pages("|')/i
    end
  end

  describe 'adding the page to the wiki' do
    describe 'if a non empty title is provided and no page with the given title exists' do
      before do
        @page_title = 'the page title'
        @page_content = 'the page content'
        @response = post '/new-page', {:title => @page_title, :content => @page_content}
      end

      it 'adds the page' do
        last_page = wiki.pages.last
        last_page.title.must_equal @page_title
        last_page.content.must_equal @page_content
      end

      it 'renders the edit page form for the added page' do
        @response.code.must_equal '302'
        @response.body.must_match '/the-page-title'
      end
    end

=begin
    describe 'handles a page with ñ or Ñ in the title' do
      before do
        @page_title = 'title with a ñ and a Ñ'
        @page_content = 'some content'
        @response = post '/new-page', {:title => @page_title, :content => @page_content}
      end

      it 'adds the page' do
        last_page = wiki.pages.last
        last_page.title.must_equal @page_title
        last_page.content.must_equal @page_content
      end

      it 'renders the edit page form for the added page' do
        @response.code.must_equal '302'
        @response.body.must_match '/title-with-a-n-and-a-n'
      end
    end
=end

    describe 'if the title is not provided (empty)' do
      before do
        @content = 'some content'
        @response = post '/new-page', {:content => @content}
      end

      it 'prompts an error message' do
        @response.body.must_match /must have a title/
      end

      it 'mantains the written content' do
        @response.body.must_match /#{@content}/
      end
    end

    describe 'if another page with the same title exists' do
      before do
        @titile = 'The Title'
        @content = 'some content'
        wiki.publish Niki::Page.new(@title)
        @response = post '/new-page', {:title => @title, :content => @content}
      end

      it 'prompts an error message' do
        @response.body.must_match /title .* must be different from other pages'/
      end

      it 'mantains the written title' do
        @response.body.must_match /#{@title}/
      end

      it 'mantains the written content' do
        @response.body.must_match /#{@content}/
      end
    end
  end
end
