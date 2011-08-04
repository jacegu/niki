describe Page do

  describe 'a new page' do
    it 'is created witha  title' do
      the_title = 'some title'
      page = Page.new(the_title)
      page.title.must_equal the_title
    end
  end

end
