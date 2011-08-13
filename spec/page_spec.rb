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

    it 'has an empty content' do
      @page.content.must_be_empty
    end
  end

  describe '#to_s' do
    it 'returs the title of the page' do
      @page.to_s.must_equal @the_title
    end
  end

  describe '#content=' do
    it 'sets the content of the page' do
      the_page_content = 'the content for the page'
      page = Page.new('something')
      page.content = the_page_content
      page.content.must_equal the_page_content
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

  describe '#<=>' do
    it 'returns 0 if both pages have the same title ' do
      page1 = Page.new 'x'
      page2 = Page.new 'x'
      (page1 <=> page2).must_equal 0
    end
  end

  describe '::with title, content' do
    before do
      @the_title = 'title'
      @the_content = 'content'
      @page = Page.with(@the_title, @the_content)
    end

    it 'creates a page with the given title' do
      @page.title.must_equal @the_title
    end

    it 'creates a page with the given content' do
      @page.content.must_equal @the_content
    end
  end
end
