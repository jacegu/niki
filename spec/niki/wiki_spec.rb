require 'spec_helper'
require 'wiki'

module Niki
  describe Wiki do
    before do
      @wiki = Wiki.new
    end

    describe 'when created' do
      it 'has no pages' do
        @wiki.has_any_pages?.must_equal false
      end
    end

    describe '#publish page' do
      it 'adds the page to the wiki' do
        page = stub
        @wiki.publish(page)
        @wiki.pages.must_include page
      end
    end

    describe '#has_any_pages?' do
      it 'returns false if the wiki has no pages' do
        @wiki.has_any_pages?.must_equal false
      end

      it 'returns true if the wiki has any pages' do
        @wiki.publish(stub)
        @wiki.has_any_pages?.must_equal true
      end
    end

    describe '#page_with url: url' do
      describe 'if a page with that url exists 'do
        it 'returns that page' do
          the_page_url = 'some-url'
          the_page = Page.new('Some url')
          @wiki.publish(the_page)
          @wiki.page_with(url: the_page_url).must_be_same_as the_page
        end
      end

      describe 'if no page with that url exists' do
        it 'returns a null page' do
          the_page = @wiki.page_with(url: 'does-not-exist')
          the_page.class.must_equal NullPage
        end
      end
    end

    describe '#page_with title: title' do
      describe 'if a page with that title exists 'do
        it 'returns that page' do
          the_page_title = 'the title'
          the_page = Page.new(the_page_title)
          @wiki.publish(the_page)
          @wiki.page_with(title: the_page_title).must_be_same_as the_page
        end

        it 'returns that page even if it has diferent cased words' do

        end
      end

      describe 'if no page with that title exists' do
        it 'returns a null page' do
          the_page = @wiki.page_with(title: 'does not exist')
          the_page.class.must_equal NullPage
        end
      end
    end

    describe '#has_a_page_entitled? title' do
      it 'returns true if has a page with that title' do
        the_title = 'the title'
        @wiki.publish Page.new(the_title)
        @wiki.has_a_page_entitled?(the_title).must_equal true
      end

      it 'returns false if it does not have a page with that title' do
        @wiki.has_a_page_entitled?('something').must_equal false
      end
    end

    describe '#has_a_page_with_url? url' do
      it 'returns true if has a page with that url' do
        @wiki.publish Page.new('the url')
        @wiki.has_a_page_with_url?('the-url').must_equal true
      end

      it 'returns false if it does not have a page with that url' do
        @wiki.has_a_page_with_url?('something').must_equal false
      end
    end

  end
end
