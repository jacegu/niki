require 'feature_helper'
require 'http_helper'

feature 'Rendering the content of a wiki page' do

  describe 'sanitizing HTML' do
    it 'escapes every HTML tag in the page content' do
      @wiki.publish Niki::Page.with('page', "<h1>this should be sanitized</h1>")
      response = get '/pages/page'
      response.body.must_match /&lt;h1&gt;this should be sanitized&lt;\/h1&gt;/i
    end
  end

  describe 'paragraph rendering' do
    it 'wraps paragraphs with <p></p> tags' do
      @wiki.publish Niki::Page.with('page1', "some\ncontent")
      response = get '/pages/page1'
      response.body.must_match /<p>some<\/p>\n<p>content<\/p>/m
    end

    it 'does not wrap empty lines' do
      @wiki.publish Niki::Page.with('page1', "some\n\n\ncontent")
      response = get '/pages/page1'
      response.body.must_match /<p>some<\/p>\n<p>content<\/p>/m
    end
  end

  describe 'link rendering' do
    it 'renders a link to the page entitled "page1"' do
      @wiki.publish Niki::Page.with('page1', "text [page1]\n more text")
      response = get '/pages/page1'
      response.body.must_match /<a.+href=('|")\/pages\/page1('|")>page1<\/a>/i
    end

    it 'renders links to pages entitled "page1" and "page2"' do
      @wiki.publish Niki::Page.with('page1', "the content")
      @wiki.publish Niki::Page.with('page2', "text [page1]\n more text [page2]")
      response = get '/pages/page2'
      response.body.must_match /<a.+href=('|")\/pages\/page1('|")>page1<\/a>/i
      response.body.must_match /<a.+href=('|")\/pages\/page2('|")>page2<\/a>/i
    end

    it 'does not render a link if there is no page with the linked title' do
      @wiki.publish Niki::Page.with('page', "text [page that does not exist]\n more text")
      response = get '/pages/page'
      response.body.must_match /\[page that does not exist\]/i
    end
  end

end
