require 'spec_helper'
require 'niki'

module Niki
  describe Niki do
    before do
      @niki = Niki.new
    end

    describe 'when created' do
      it 'has no pages' do
        @niki.has_pages?.must_equal false
      end
    end

    describe '#add_page page' do
      it 'adds the page to the niki' do
        page = stub
        @niki.add_page(page)
        @niki.pages.must_include page
      end
    end

    describe '#has_pages?' do
      it 'returns false if niki has no pages' do
        @niki.has_pages?.must_equal false
      end

      it 'returns true if niki has any pages' do
        @niki.add_page(stub)
        @niki.has_pages?.must_equal true
      end
    end

    describe '#page_with_url url' do
      describe 'if a page with that url exists 'do
        it 'returns that page' do
          the_page_url = 'some-url'
          the_page = stub
          the_page.expect(:url, the_page_url)
          @niki.add_page(the_page)
          @niki.page_with_url(the_page_url).must_be_same_as the_page
        end
      end

      describe 'if no page with that url exists' do
        it 'returns a null page'
      end
    end
  end
end
