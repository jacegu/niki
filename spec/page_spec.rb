#encoding: utf-8

describe Page do

  before do
    @the_title = 'some title'
    @page = Page.new(@the_title)
  end

  describe 'a new page' do
    it 'is created with a title' do
      @page.title.must_equal @the_title
    end
  end

  describe '#to_s' do
    it 'returs the title of the page' do
      @page.to_s.must_equal @the_title
    end
  end

  describe '#url' do
    it 'returns the page title' do
      page = Page.new('something')
      page.url.must_equal 'something'
    end

    it 'replaces spaces with scripts' do
      page = Page.new("something with\tspaces")
      page.url.must_equal 'something-with-spaces'
    end

    it 'removes non alphan-numeric characters' do
      page = Page.new('*s",(o).#m_$e-t·h%i|n=g+')
      page.url.must_equal 'something'
    end
  end
end
