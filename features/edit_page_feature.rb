require 'feature_helper'
require 'http_helper'

feature "Showing an existing wiki page" do

  describe 'editing an existing page' do
    before do
      @page_title = 'Testing page'
      @page_content = "Content\nfor\nthis\npage"
      @wiki.add_page Niki::Page.with(@page_title, @page_content)

      response =  get '/pages/testing-page/edit'
      @page_html = response.body
    end

    it 'renders a form with the page title and content' do
      @page_html.must_match /<form.+method=('|")post('|").+action=('|")\/pages\/testing-page('|").+/i
    end

    it 'renders a text field with the page title' do
      @page_html.must_match /<input.+type=('|")text('|").+name=('|")title('|").+value=('|")#{@page_title}('|").+/i
    end

    it 'renders a textearea with the page content' do
      @page_html.must_match /<textarea.+name=('|")content('|").*>.*#{@page_content}.*<\/textarea>/i
    end

    it 'renders a save changes button' do
      @page_html.must_match /<input.*type=('|")submit('|").+Save Changes/i
    end
  end

  describe 'updating an existing page' do
    before do
      @wiki.add_page Niki::Page.with('some title', 'some content')
      @updated_title = "Updated page's title"
      @updated_content = "Updated page's content"
      @response = post '/pages/some-title', {:title => @updated_title, :content => @updated_content}
      @updated_page = @wiki.page_with_url('updated-pages-title')
    end

    it "updates the page's title" do
      @updated_page.title.must_equal @updated_title
    end

    it "updates the page's content" do
      @updated_page.content.must_equal @updated_content
    end

    it 'rendirects to the page' do
      @response.code.must_equal '302'
      @response.body.must_match /\/pages\/updated-pages-title/
    end
  end

end
