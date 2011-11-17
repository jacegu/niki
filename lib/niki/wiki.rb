require 'niki/page'

module Niki
  class Wiki
    attr_reader :pages

    def initialize(pages = [])
      @pages = pages
    end

    def add_page(page)
      Wiki.new self.pages.push(page)
    end

    def has_pages?
      pages.any?
    end

    def has_a_page_entitled?(title)
      page_with_title(title).found?
    end

    def page_with_url(url)
      find_page_by{ |p| p.url == url }
    end

    def page_with_title(title)
      find_page_by{ |p| p.title == title }
    end

    def find_page_by(&criteria)
      pages.select(&criteria).first || NullPage.new
    end
  end
end
