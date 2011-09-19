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

    def has_a_page_entitled?(title)
      page_with_title(title).found?
    end

    def page_with_url(url)
      pages.select{ |p| p.url == url }.first || NullPage.new
    end

    def page_with_title(title)
      pages.select{ |p| p.title == title }.first || NullPage.new
    end
  end
end
