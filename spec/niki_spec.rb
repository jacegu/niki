require 'spec_helper'

describe Niki do
  before do
    @niki = Niki.new
  end

  describe 'when created' do
    it 'has no pages' do
      @niki.pages.must_be_empty
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
end
