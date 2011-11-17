#encoding: utf-8
require 'spec_helper'
require 'page'

module Niki
  describe Page do

    describe 'a new page' do
      before do
        @the_title = 'some title'
        @page = Page.new(@the_title)
      end

      it 'has a title' do
        @page.title.must_equal @the_title
      end

      it 'has an empty content' do
        @page.content.must_be_empty
      end
    end

    describe '#title=' do
      it 'updates the title of the page' do
        the_page_title = 'the new title of the page'
        page = Page.new('old title')
        page.title = the_page_title
        page.title.must_equal the_page_title
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

      it 'downcases every letter in the title' do
        page = Page.new('SoMeTHinG With UPPERCASE')
        page.url.must_equal 'something-with-uppercase'
      end

      it 'handles ñ character and replaces it with an n' do
        page = Page.new('ñoÑo')
        page.url.must_equal 'nono'
      end
    end

    describe '#found?' do
      it 'is always true' do
        page = Page.new('title')
        page.found?.must_equal true
      end
    end

    describe '#to_s' do
      it 'returs the title of the page' do
        page_title = 'some title'
        Page.new(page_title).to_s.must_equal page_title
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

    describe '::would_be_valid_with_title? title' do
      describe 'if the title contains at least an alphanumeric character' do
        it 'returns true' do
          Page.would_be_valid_with_title?('some title').must_equal true
        end
      end

      describe 'if the title does not contain an alphanumeric character' do
        it 'returns false' do
          Page.would_be_valid_with_title?('    ').must_equal false
        end
      end
    end
  end

  describe NullPage do
    before do
      @null_page = NullPage.new
    end

    it 'has an empty title' do
      @null_page.title.must_be_empty
    end

    it 'has an empty url' do
      @null_page.url.must_be_empty
    end

    it 'is never found' do
      @null_page.found?.must_equal false
    end
  end

end
