require 'spec_helper'
require 'page_request'

module Niki
  describe PageRequest do

    ALL_PAGES_PATH = '/pages'

    describe 'a new page request' do
      it 'is created with a path' do
        the_path = '/some-path'
        requested = PageRequest.new(the_path)
        requested.path.must_equal the_path
      end
    end

    describe '#all_pages?' do
      it 'returns true if requested path is "/pages"' do
        requested = PageRequest.new(ALL_PAGES_PATH)
        requested.all_pages?.must_equal true
      end

      it 'returns false for every other path' do
        requested = PageRequest.new('/some-path')
        requested.all_pages?.must_equal false
      end
    end

    describe '#page_url' do
      describe 'all pages were requested' do
        it 'returns an empty string as page title' do
          requested = PageRequest.new(PageRequest::ALL_PAGES_PATH)
          requested.page_url.must_be_empty
        end
      end

      describe 'a particular page was requested' do
        before do
          @the_page_url = 'writting-a-cool-wiki'
        end

        it 'extracts the requested url from the requested path' do
          requested_path = "/pages/#{@the_page_url}"
          requested = PageRequest.new(requested_path)
          requested.page_url.must_equal @the_page_url
        end

        it 'removes the action from the url' do
          requested_path = "/pages/#{@the_page_url}/action"
          requested = PageRequest.new(requested_path)
          requested.page_url.must_equal @the_page_url
        end
      end
    end

    describe '#action' do
      describe 'if all pages were requested' do
        it 'returns "none" as requested action' do
          requested = PageRequest.new(ALL_PAGES_PATH)
          requested.action.must_equal :none
        end
      end

      describe 'a particular page was requested' do
        it 'returns the string after the requested page url as action' do
          page_and_action = '/pages/the-page-url/action'
          requested = PageRequest.new(page_and_action)
          requested.action.must_equal :action
        end
      end
    end

  end
end
