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

    it 'returns true if requested path is "/pages/"' do
      all_pages_path = '/pages/'
      requested = PageRequest.new(all_pages_path)
      requested.all_pages?.must_equal true
    end

    it 'returns false for every other path' do
      requested = PageRequest.new('/somepath')
      requested.all_pages?.must_equal false
    end
  end

end
