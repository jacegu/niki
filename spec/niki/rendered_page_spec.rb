require 'spec_helper'
require 'rendered_page'

module Niki
  describe RenderedPage do
    before do
      @the_title = 'page title'
      @the_page_to_render = Page.new(@the_title)
      @the_wiki = Wiki.new
      @the_wiki.add_page(@the_page_to_render)
      @rendered_page = RenderedPage.new(@the_page_to_render, @the_wiki)
    end

    describe '#new page_to_render wiki' do
      it 'is created with a page to render' do
        @rendered_page.page.must_be_same_as @the_page_to_render
      end

      it 'is created with the wiki' do
        @rendered_page.wiki.must_be_same_as @the_wiki
      end
    end

    describe '#title' do
      it 'returns the title of the page to render' do
        @rendered_page.title.must_equal @the_page_to_render.title
      end
    end

    describe '#url' do
      it 'renturs the url of the page to render 'do
        @rendered_page.url.must_equal @the_page_to_render.url
      end
    end

    describe '#content' do
      it 'wraps a single line inside html paragraphs' do
        the_content = 'content'
        @the_page_to_render.content = the_content
        @rendered_page.content.must_equal "<p>content</p>"
      end

      it 'wraps several lines inside html paragraphs' do
        @the_page_to_render.content = "Some\ncontent\nfor\nthe\npage"
        @rendered_page.content.must_equal "<p>Some</p>\n<p>content</p>\n<p>for</p>\n<p>the</p>\n<p>page</p>"
      end

      it 'replaces [page title] for <a href="/pages/page-title">page title</a>' do
        @the_page_to_render.content = 'some content for the page wiht a link to itself [page title]'
        @rendered_page.content.must_match /<a href="\/pages\/page-title">page title<\/a>/
      end

      it 'replaces every link in the content' do
        @the_wiki.add_page Page.new('second')
        @the_wiki.add_page Page.new('third')
        @the_page_to_render.content = 'first: [page title] second: [second] third: [third]'
        rendered_content = @rendered_page.content
        rendered_content.must_match /<a href="\/pages\/page-title">page title<\/a>/
        rendered_content.must_match /<a href="\/pages\/second">second<\/a>/
        rendered_content.must_match /<a href="\/pages\/third">third<\/a>/
      end

      it 'does not replace the link if there is no page entitled like that' do
        @the_page_to_render.content = 'lorem [this does not exist] ipsum'
        @rendered_page.content.must_match /lorem \[this does not exist\] ipsum/
      end
    end
  end
end
