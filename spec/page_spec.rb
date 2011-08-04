describe Page do

  before do
    @the_title = 'some title'
    @page = Page.new(@the_title)
  end

  describe 'a new page' do
    it 'is created witha  title' do
      @page.title.must_equal @the_title
    end
  end

  describe '#to_s' do
    it 'returs the title of the page' do
      @page.to_s.must_equal @the_title
    end
  end
end
