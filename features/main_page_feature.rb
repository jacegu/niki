require 'feature_helper'
require 'http_helper'

feature "Wiki's Main Page" do

  it 'shows a link to create a new page' do
    response = get '/pages'
    response.body.must_match /<a .*href=('|")\/new-page('|")/
  end

  describe 'if no page has been created' do
    it 'prompts a message telling there are no pages created' do
      response = get '/pages'
      response.body.must_match /no page has been created/i
    end
  end

  describe 'if pages have been created' do
    before do
      @the_page_title = 'page title'
      @wiki.add_page Niki::Page.new(@the_page_title)
      response = get '/pages'
      @response_body = response.body
    end

    it 'lists them showing their title' do
      @response_body.must_match /#{@the_page_title}/
    end

    it 'prompts a link to each page' do
      @response_body.must_match /<a .*href=('|")\/pages\/page-title('|")/
    end
  end

end
