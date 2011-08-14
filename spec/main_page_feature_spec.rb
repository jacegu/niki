require 'feature_helper'
require 'http_helper'

feature "Niki's Main Page" do

  it 'shows a link to create a new page' do
    response = get '/'
    response.body.must_match /<a .*href=('|")\/new-page('|")/
  end

  describe 'if no page has been created' do
    it 'prompts a message telling there are no pages created' do
      response = get '/'
      response.body.must_match /no niki has been created/
    end
  end

  describe 'if pages have been created' do
    before do
      @the_page_title = 'page title'
      @niki.add_page Page.new(@the_page_title)
    end

    it 'lists them showing their title' do
      response = get '/'
      response.body.must_match /#{@the_page_title}/
    end

    it 'prompts a link to each page' do
      response = get '/'
      response.body.must_match /<a .*href=('|")\/page-title('|")/
    end
  end

end
