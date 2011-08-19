require 'page_request'

describe PageRequest do
  describe 'a new page request' do
    it 'is created witha path' do
      the_path = '/some-path'
      requested = PageRequest.new(the_path)
      requested.path.must_equal the_path
    end
  end

  describe '#all_pages?' do
    it 'returns true if requested path is "/pages"' do
      all_pages_path = '/pages'
      requested = PageRequest.new(all_pages_path)
      requested.all_pages?.must_equal true
    end

    it 'returns false for every other path' do
      requested = PageRequest.new('/somepath')
      requested.all_pages?.must_equal false
    end
  end

  describe '#page_title' do
    describe 'all pages were requested' do
      it 'returns an empty string as page title' do
        requested = PageRequest.new(PageRequest::ALL_PAGES_PATH)
        requested.page_title.must_be_empty
      end
    end

    describe 'a particular page was requested' do
      it 'extracts the requested title from the requested path' do
        the_page_title = 'writting-a-cool-wiki'
        requested_path = "/pages/#{the_page_title}"
        requested = PageRequest.new(requested_path)
        requested.page_title.must_equal the_page_title
      end
    end
  end

end