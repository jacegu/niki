require 'niki/page'

module Niki
  class Wiki
    attr_reader :pages

    def initialize
      @pages = []
    end

    def add_page(page)
      pages << page
    end

    def has_pages?
      pages.any?
    end

    def page_with_url(url)
      page = pages.select{ |p| p.url == url }.first
      if page
        page
      else
        NullPage.new
      end
    end
  end
end
