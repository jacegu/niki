require 'page_request'

describe PageRequest do
  describe 'a new page request' do
    it 'is created witha path' do
      the_path = '/all'
      requested = PageRequest.new(the_path)
      requested.path.must_equal the_path
    end
  end
end
