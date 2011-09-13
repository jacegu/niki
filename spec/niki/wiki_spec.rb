require 'spec_helper'
require 'wiki'

module Niki
  describe Wiki do
    before do
      @wiki = Wiki.new
    end

    describe 'when created' do
      it 'has no pages' do
        @wiki.has_pages?.must_equal false
      end
    end

    describe '#add_page page' do
      it 'adds the page to the wiki' do
        page = stub
        @wiki.add_page(page)
        @wiki.pages.must_include page
      end
    end

    describe '#has_pages?' do
      it 'returns false if the wiki has no pages' do
        @wiki.has_pages?.must_equal false
      end

      it 'returns true if the wiki has any pages' do
        @wiki.add_page(stub)
        @wiki.has_pages?.must_equal true
      end
    end

    describe '#page_with_url url' do
      describe 'if a page with that url exists 'do
        it 'returns that page' do
          the_page_url = 'some-url'
          the_page = stub
          the_page.expect(:url, the_page_url)
          @wiki.add_page(the_page)
          @wiki.page_with_url(the_page_url).must_be_same_as the_page
        end
      end

      describe 'if no page with that url exists' do
        it 'returns a null page' do
          the_page = @wiki.page_with_url('does-not-exist')
          the_page.class.must_equal NullPage
        end
      end
    end

    describe '#page_with_title title' do
      describe 'if a page with that title exists 'do
        it 'returns that page' do
          the_page_title = 'the title'
          the_page = stub
          the_page.expect(:title, the_page_title)
          @wiki.add_page(the_page)
          @wiki.page_with_title(the_page_title).must_be_same_as the_page
        end
      end

      describe 'if no page with that title exists' do
        it 'returns a null page' do
          the_page = @wiki.page_with_title('does not exist')
          the_page.class.must_equal NullPage
        end
      end
    end

    describe '#has_a_page_with_title title' do
      it 'returns true if has a page with that title' do
        the_title = 'the title'
        @wiki.add_page Page.new(the_title)
        @wiki.has_a_page_with_title?(the_title).must_equal true
      end

      #it 'returns false if it does not have a page with that title' do

      #end
    end
  end
end
